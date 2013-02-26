use Test::More tests => 22;

package Baz;
use Mo qw(default);
has foo => { less => 'Mo' };
has fu  => {};
has bar => '';
has baz => 123;
has jar => [ 4, 2, 42 ];
has mar => [];

has something => ( default => sub { [] } );
has anything  => ( default => sub { +{} } );
has nothing   => ( default => sub { 0 } );

has past => ( default => sub { [ 1, 2, 3 ] } );
has present => ( default => sub { +{ a => 'A', b => 'B', C => 'c' } } );
has future => ( default => sub { 42 } );


has fate => ();

package main;

# Regulars
my $foo = new_ok('Baz');
is_deeply $foo->something, [], 'Empty array';
is_deeply $foo->anything, {}, 'Empty hash';
is $foo->nothing, 0, 'Falseish Scalar';
is_deeply $foo->past, [ 1, 2, 3 ], 'Non empty array';
is_deeply $foo->present, { a => 'A', b => 'B', C => 'c' }, 'Non empty hash';
is $foo->future, 42, 'The answer to life the universe and everything';
is $foo->fate, undef, 'all the little unknowns..';

# Terse
is $foo->bar, '',  'Falseish default';
is $foo->baz, 123, 'Truish default';
is_deeply $foo->fu, {}, 'correct default';
is_deeply $foo->foo, { less => 'Mo' }, 'correct default';
is_deeply $foo->mar, [], 'correct default';
is_deeply $foo->jar, [ 4, 2, 42 ], 'correct default';
isnt( Baz->new->foo, Baz->new->foo, 'get new instances on every call' );
is_deeply( Baz->new->foo, Baz->new->foo, '.. but their content are the same' );

# Constructor arguments
$foo = new_ok( 'Baz', [ baz => 'changed', fu => 'none' ] );
is $foo->baz, 'changed', 'default can be overriden';
is $foo->fu,  'none',    'default can be overriden';

# Setters
$foo->past(undef);
$foo->present( {} );
$foo->future( [] );
is $foo->past, undef, 'set to undef';
is_deeply $foo->present, {}, 'set to empty hash';
is_deeply $foo->future, [], 'the future isnt bright';
