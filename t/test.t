use Test::More tests => 8;

package Foo;
use Mo;

has 'this';

package Bar;
use Mo;
extends 'Foo';

has 'that';

package Baz;

@ISA = qw( Bar );

package main;

my $bar = Bar->new(
    this => 'thing',
    that => 'thong',
);

is ref($bar), 'Bar', 'Object created';

ok $bar->isa('Foo'), 'Inheritance works';

is $bar->this, 'thing', 'Read works';
is $bar->that, 'thong', 'Read works in parent class';

$bar->this('thang');

is $bar->this, 'thang', 'Write works';

my $baz = Baz->new(
    this => 'thong',
    that => 'thing',
);

is ref( $baz ), 'Baz', 'Object created';

is $baz->this, 'thong', 'Read works';
is $baz->that, 'thing', 'Read works in parent class';
