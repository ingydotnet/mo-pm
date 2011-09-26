use Test::More;
use Test::InDistDir;
use lib 'src';
plan tests => 3;

#============
package Foo;
use Mo 'autobuild';

has 'this';
has 'that' => ( builder => 'that_builder' );
has 'auto' => ( builder => 1 );

use constant that_builder => 'O HAI';
use constant _build_auto  => 'like a car';

#============
package main;

my $f = Foo->new( this => 'thing' );

is $f->this, 'thing',      'Plain accessor works';
is $f->that, 'O HAI',      'builder works';
is $f->auto, 'like a car', 'auto builder works';
