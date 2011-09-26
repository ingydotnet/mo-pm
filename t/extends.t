use Test::More tests => 15;

use lib 't';
use Bar;
use Baz;
use Goo;

foreach my $class (qw<Bar Baz Goo>) {
    my $b = $class->new;

    isa_ok $b, $class;
    isa_ok $b, 'Foo';

    is "@Bar::ISA", "Foo", 'Extends with multiple classes not supported';

    ok 'Foo'->can('stuff'), 'Foo is loaded';
    ok not('Bar'->can('buff')), 'Boo is not loaded';
}
