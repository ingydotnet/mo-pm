#!/usr/bin/perl

undef $/;

my $text = <>;

$text =~ s/(\w)\s+([^\w])/$1$2/g;
$text =~ s/([^\w])\s+/$1/g;
$text =~ s/;\}/}/g;
$text =~ s/(VERSION.*?;)/$1\n/;

print $text;
