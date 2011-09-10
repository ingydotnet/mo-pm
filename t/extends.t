use Test::More tests => 4;

use lib 't';
use Bar;

my $b = Bar->new;

ok $b->isa('Foo'), 'Bar is a subclass of Foo';

is "@Bar::ISA", "Foo Boo", 'Extends adds multiple classes';

ok 'Foo'->can('stuff'), 'Foo is loaded';
ok 'Bar'->can('buff'), 'Boo is loaded';
