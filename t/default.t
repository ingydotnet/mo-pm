use Test::More tests => 10;

package Baz;
use Mo qw(default);
has z => (default => 999);
has baz   => 123;
has bazed => {};
has foo   => { less => 'Mo' };

package main;

my $foo = new_ok('Baz');
is $foo->z, 999, 'simple case';
is $foo->baz,   123,   'used default value';
is_deeply $foo->bazed, {}, 'correct default';
is_deeply $foo->foo, { less => 'Mo' }, 'correct default';
isnt(Baz->new->foo, Baz->new->foo, 'get new instances on every call');
is_deeply(Baz->new->foo, Baz->new->foo, '.. but their content are the same');

$foo = new_ok( 'Baz', [ baz => 'changed', bazed => 'none' ] );
is $foo->baz,   'changed', 'default can be overriden';
is $foo->bazed, 'none',    'default can be overriden';
