#!/usr/bin/perl

use strict;
use warnings;
use PPI;

my $text = do {
    local undef $/;
    <>;
};

binmode STDOUT;

print golf_with_regex( $text );

#print golf_with_ppi( $text );

sub golf_with_regex {
    my ( $text ) = @_;

    $text =~ s/^#.*\n//mg;
    $text =~ s/\s*#'.*//;

    #$text =~ s/(\w)\s+([^\w])/$1$2/g;
    #$text =~ s/([^\w])\s+/$1/g;
    #$text =~ s/;\}/}/g;
    #$text =~ s/(\$VERSION.*?;)/\n$1\n/;
    #$text =~ s/(no\$)/no \$/;
    #$text .= "\n";

    return $text;
}

sub golf_with_ppi {
    my ( $text ) = @_;

    my $tree = PPI::Document->new( \$text );

    my $comments = $tree->find( 'PPI::Token::Comment' );
    $_->delete for @{$comments};

    return $tree->serialize;
}
