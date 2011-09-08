use Test::More tests => 8;

package Foo;
use Mo;

has 'this';

package Bar;
use Mo;
extends 'Foo';

has 'that';

package Baz;
use Mo;

has 'foo';

sub BUILD {
    my $self = shift;
    $self->foo(5);
}

package Maz;
use Mo;
extends 'Baz';

has 'bar';

sub BUILD {
    my $self = shift;
    $self->SUPER::BUILD();
    $self->bar(7);
}

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

my $baz = Baz->new;
is $baz->foo, 5, 'BUILD works';

my $maz = Maz->new;
is $maz->foo, 5, 'BUILD works again';
is $maz->bar, 7, 'BUILD works in parent class';
