use Test::More;

plan tests => 4;

#============
package Foo;

use Mo 'default', 'class_xsaccessor', 'builder';

has 'this';
has 'that' => (builder => 'that_builder');
has 'them' => (default => sub {[]});

use constant that_builder => 'O HAI';

#============
package main;

my $f = Foo->new(this => 'thing');

is $f->this, 'thing', 'constructor works';

$f->this('thing2');

is $f->this, 'thing2', 'XS accessor works';

is $f->that, 'O HAI', 'builder still works';

is ref $f->them, 'ARRAY', 'default still works';
