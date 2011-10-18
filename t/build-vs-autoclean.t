package main;

use Test::More;

package test::modules;

BEGIN {
    eval "use Sub::Name; use namespace::autoclean";
    $@ and main::plan skip_all => "Sub::Name and namespace::autoclean are needed";
};

package main;

plan tests => 1;

$main::count = 0;

package Foo;
use namespace::autoclean;
use Mo 'build';

sub BUILD {
    my $self = shift;
    $main::count++;
}

package main;

my $g = Foo->new;
is $main::count, 1, 'BUILD called';
