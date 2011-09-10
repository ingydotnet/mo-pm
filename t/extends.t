use Test::More tests => 1;

use lib 't';
use Bar;

my $b = Bar->new;

ok $b->isa('Foo'), 'Bar is a subclass of Foo';
