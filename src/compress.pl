#!/usr/bin/perl

undef $/;

my $text = <>;

$text =~ s/\s*#'.*//;
$text =~ s/(\w)\s+([^\w])/$1$2/g;
$text =~ s/([^\w])\s+/$1/g;
$text =~ s/(\$Mo'VERSION.*?;)/$1\n/;
$text =~ s/(no\$)/no \$/;

print $text;
