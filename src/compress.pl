#!/usr/bin/perl

use strict;
use warnings;
use PPI;

my $text = do {
    local undef $/;
    <>;
};

binmode STDOUT;

#print golf_with_regex( $text );

print golf_with_ppi( $text );

sub golf_with_regex {
    my ( $text ) = @_;

    $text =~ s/^#.*\n//mg;
    $text =~ s/\s*#'.*//;
    $text =~ s/(\w)\s+([^\w])/$1$2/g;
    $text =~ s/(no\$)/no \$/;
    $text =~ s/([^\w])\s+/$1/g;

    #$text =~ s/;\}/}/g;
    #$text =~ s/(\$VERSION.*?;)/\n$1\n/;
    #$text .= "\n";

    return $text;
}

sub tok { "PPI::Token::$_[0]" }

sub golf_with_ppi {
    my ( $text ) = @_;

    my $tree = PPI::Document->new( \$text );

    my %finder_subs = (
        comments => sub { $_[1]->isa( 'PPI::Token::Comment' ) },

        whitespace => sub {
            my ( $top, $current ) = @_;
            return 0 if !$current->isa( 'PPI::Token::Whitespace' );
            my $prev = $current->previous_token;
            my $next = $current->next_token;
            return 1
              if $prev->isa( 'PPI::Token::ArrayIndex' )
                  and $next->isa( 'PPI::Token::Whitespace' )
                  and $next->next_token->isa( 'PPI::Token::Operator' ); # !!! change this to collapse double whitespaces

            return 1
              if $prev->isa( 'PPI::Token::Symbol' )
                  and $next->isa( 'PPI::Token::Whitespace' )
                  and $next->next_token->isa( 'PPI::Token::Operator' ); # !!! change this to collapse double whitespaces

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
            return 1 if $prev->isa( tok 'Operator' );                                            # = 0.24
            return 1 if $prev->isa( tok 'Quote::Double' );                                       # " .

            return 0;
        },
    );

    # whitespace needs to be double for now so i can compare things easier, needs to go later
    my @order = qw( comments whitespace whitespace trailing_whitespace trailing_whitespace );

    for my $name ( @order ) {
        my $elements = $tree->find( $finder_subs{$name} ) || [];
        $_->delete for @{$elements};
    }

    return $tree->serialize;
}
