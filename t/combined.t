use Test::More;

plan tests => 4;

#============
package Foo;
use Mo qw(builder default coerce);

has 'this';
has 'that' => (builder => 'that_builder', coerce => sub {lc $_[0]});
has 'them' => (default => sub {[]});

use constant that_builder => 'O HAI';

#============
package main;

my $f = Foo->new(this => 'thing');

is $f->this, 'thing', 'Plain accessor works';

is $f->that, 'O HAI', 'builder works';

$f->that('O HEY');
is $f->that, 'o hey', 'coerce works';

is ref($f->them), 'ARRAY', 'default works';
