#!/usr/bin/perl

undef $/;

my $text = <>;

$text =~ s/(\w)\s+([^\w])/$1$2/g;
$text =~ s/([^\w])\s+/$1/g;
$text =~ s/(\$VERSION.*?;)/\n$1\n/;
$text =~ s/(require)/$1 /;

print $text;
