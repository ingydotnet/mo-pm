use Test::More;

plan tests => 5;

#============
package Foo;
use Mo qw(builder default coerce is);

has 'this';
has 'that' => (builder => 'that_builder', coerce => sub {lc $_[0]});
has 'them' => (default => sub {[]});
has 'coerced_readonly' => (is => 'ro', coerce => sub {uc $_[0]});

use constant that_builder => 'O HAI';

#============
package main;

my $f = Foo->new(this => 'thing', coerced_readonly => 'th1ng');

is $f->this, 'thing', 'Plain accessor works';

is $f->that, 'O HAI', 'builder works';

$f->that('O HEY');
is $f->that, 'o hey', 'coerce works';

is $f->coerced_readonly, 'TH1NG', 'coerce works for readonly accessors';

is ref($f->them), 'ARRAY', 'default works';
