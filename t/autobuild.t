use Test::More;
use lib 'src';
plan tests => 3;

#============
package Foo;
use Mo 'autobuild';

use constant that_builder => 'O HAI';
use constant _build_auto  => 'like a car';

has 'this';
has 'that' => ( builder => 'that_builder' );
has 'auto' => ( builder => 1 );
#============

package main;

my $f = Foo->new( this => 'thing' );

is $f->this, 'thing',      'Plain accessor works';
is $f->that, 'O HAI',      'builder works';
is $f->auto, 'like a car', 'auto builder works';
