use Test::More;

plan tests => 3;

#============
package Foo;
use Mo 'has';

has 'this';
has 'that' => (builder => 'that_builder');
has 'them' => (default => sub {[]});

use constant that_builder => 'O HAI';

#============
package main;

my $f = Foo->new(this => 'thing');

is $f->this, 'thing', 'Plain accessor works';

is $f->that, 'O HAI', 'builder works';

is ref($f->them), 'ARRAY', 'default works';
