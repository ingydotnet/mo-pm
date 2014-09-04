use strict; use warnings;

use File::Basename;
use lib dirname(__FILE__), 'inc';

use Test::More tests => 2;

{ package Clean; use Foo; }

is_deeply([ @Clean::ISA ], [], "Didn't mess with caller's ISA");
is(Clean->can('has'), undef, "Didn't export anything");
