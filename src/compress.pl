#!/usr/bin/perl

use strict;
use warnings;
use PPI;

my $text = do {
    local undef $/;
    <>;
};

binmode STDOUT;
print golf_with_ppi( $text );

sub tok { "PPI::Token::$_[0]" }

sub finder_subs {
    return (
        comments => sub { $_[1]->isa( 'PPI::Token::Comment' ) },

        duplicate_whitespace => sub {
            my ( $top, $current ) = @_;
            return 0 if !$current->isa( 'PPI::Token::Whitespace' );
            return 0 if !$current->next_token;
            return 0 if !$current->next_token->isa( 'PPI::Token::Whitespace' );
            return 1;
        },

        whitespace => sub {
            my ( $top, $current ) = @_;
            return 0 if !$current->isa( 'PPI::Token::Whitespace' );
            my $prev = $current->previous_token;
            my $next = $current->next_token;

            return 1 if $prev->isa( tok 'Word' ) and $next->isa( tok 'Operator' ) and $next->content =~ /^\W/;   # my $P

            return 1 if $prev->isa( tok 'Symbol' )     and $next->isa( tok 'Operator' );         # $VERSION =
            return 1 if $prev->isa( tok 'Word' )       and $next->isa( tok 'Symbol' );           # my $P
            return 1 if $prev->isa( tok 'Word' )       and $next->isa( tok 'Structure' );        # sub {
            return 1 if $prev->isa( tok 'Word' )       and $next->isa( tok 'Quote::Double' );    # eval "
            return 1 if $prev->isa( tok 'Symbol' )     and $next->isa( tok 'Structure' );        # %a )
            return 1 if $prev->isa( tok 'ArrayIndex' ) and $next->isa( tok 'Operator' );         # $#_ ?
            return 1 if $prev->isa( tok 'Word' )       and $next->isa( tok 'Cast' );             # exists &$_
            return 0;
        },

        trailing_whitespace => sub {
            my ( $top, $current ) = @_;
            return 0 if !$current->isa( 'PPI::Token::Whitespace' );
            my $prev = $current->previous_token;

            return 1 if $prev->isa( tok 'Structure' );                                           # ;[\n\s]
            return 1 if $prev->isa( tok 'Operator' ) and $prev->content =~ /\W$/;                # = 0.24
            return 1 if $prev->isa( tok 'Quote::Double' );                                       # " .
            return 1 if $prev->isa( tok 'Quote::Single' );                                       # ' }

            return 0;
        },

        double_semicolon => sub {
            my ( $top, $current ) = @_;
            return 0 if !$current->isa( tok 'Structure' );
            return 0 if $current->content ne ';';

            my $prev = $current->previous_token;

            return 0 if !$prev->isa( tok 'Structure' );
            return 0 if $prev->content ne ';';

            return 1;
        },

        del_last_semicolon_in_block => sub {
            my ( $top, $current ) = @_;
            return 0 if !$current->isa( 'PPI::Structure::Block' );

            my $last = $current->last_token;

            return 0 if !$last->isa( tok 'Structure' );
            return 0 if $last->content ne '}';

            my $maybe_semi = $last->previous_token;

            return 0 if !$maybe_semi->isa( tok 'Structure' );
            return 0 if $maybe_semi->content ne ';';

            $maybe_semi->delete;

            return 1;
        },

        del_superfluous_concat => sub {
            my ( $top, $current ) = @_;
            return 0 if !$current->isa( tok 'Operator' );

            my $prev = $current->previous_token;
            my $next = $current->next_token;

            return 0 if $current->content ne '.';
            return 0 if !$prev->isa( tok 'Quote::Double' );
            return 0 if !$next->isa( tok 'Quote::Double' );

            $current->delete;
            $prev->set_content( $prev->{separator} . $prev->string . $next->string . $prev->{separator} );
            $next->delete;

            return 1;
        },

        separate_version => sub {
            my ( $top, $current ) = @_;
            return 0 if !$current->isa( 'PPI::Statement' );

            my $first = $current->first_token;
            return 0 if $first->content ne '$VERSION';

            $current->$_( PPI::Token::Whitespace->new( "\n" ) ) for qw( insert_before insert_after );

            return 1;
        },

        shorten_var_names => sub {
            my ( $top, $current ) = @_;
            return 0 if !$current->isa( tok 'Symbol' );

            my $name = $current->canonical;

            my %short_names = shortened_var_names();

            die "variable $name conflicts with shortened var name" if grep { $name eq $_ } values %short_names;

            my $short = $short_names{$name};
            $current->set_content( $short ) if $short;

            return 1;
        },
    );
}

sub shortened_var_names {
    return (
        '%args'       => '%a',
        '$args'       => '$a',
        '@build_subs' => '@B',
        '$builder'    => '$b',
        '$class'      => '$c',
        '$default'    => '$d',
        '%exports'    => '%e',
        '$exports'    => '$e',
        '%handlers'   => '%h',
        '$handlers'   => '$h',
        '$MoPKG'      => '$K',
        '$name'       => '$n',
        '$old_export' => '$o',
        '$caller_pkg' => '$P',
        '$self'       => '$s',
        '$method'     => '$m',
    );
}

sub golf_with_ppi {
    my ( $text ) = @_;

    my $tree = PPI::Document->new( \$text );

    my %finder_subs = finder_subs();

    my @order = qw( comments duplicate_whitespace whitespace trailing_whitespace );

    for my $name ( @order ) {
        my $elements = $tree->find( $finder_subs{$name} );
        die $@ if !defined $elements;
        $_->delete for @{ $elements || [] };
    }

    $tree->find( $finder_subs{$_} )
      for qw( del_superfluous_concat del_last_semicolon_in_block separate_version shorten_var_names );
    die $@ if $@;

    for my $name ( 'double_semicolon' ) {
        my $elements = $tree->find( $finder_subs{$name} );
        die $@ if !defined $elements;
        $_->delete for @{ $elements || [] };
    }

    return $tree->serialize . "\n";
}
