#!/usr/bin/perl

undef $/;

my $text = <>;

$text =~ s/^#.*\n//mg;
$text =~ s/\s*#'.*//;
$text =~ s/(\w)\s+([^\w])/$1$2/g;
$text =~ s/([^\w])\s+/$1/g;
$text =~ s/;\}/}/g;
$text =~ s/(\$VERSION.*?;)/\n$1\n/;
$text =~ s/(no\$)/no \$/;
$text .= "\n";

print $text;
