use Test::More;

plan tests => 2;

#============
package Foo;
use Mo 'class_xsaccessor';

has 'this';
has 'that';
has 'them';

#============
package main;

my $f = Foo->new(this => 'thing');

is $f->this, 'thing', 'Plain accessor works';

$f->that('O HAI');

is $f->that, 'O HAI', 'setter works';
