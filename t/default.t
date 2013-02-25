use Test::More tests => 10;

is(
    eval {
        package Foo;
        use Mo qw(default);
        has fooz => ( default => 123 );
        1;
    },
    undef,
    'default dies when not given coderef'
);
like $@, qr/fooz not a code ref/, '.. dies with clear error message';

is(
    eval {
        package Bar;
        use Mo qw(default);
        has baz => ( default => 0 );
        1;
    },
    undef,
    'default dies when not given coderef even when passed 0'
);
like $@, qr/baz not a code ref/, '.. dies with clear error message';

package Baz;
use Mo qw(default);
has baz   => ( default => sub { 123 } );
has bazed => ( default => sub { 0 } );

package main;

my $foo = new_ok('Baz');
is $foo->baz,   123,   'used default value';
is $foo->bazed, 0, '0 as default is valid';

$foo = new_ok( 'Baz', [ baz => 'changed', bazed => 'none' ] );
is $foo->baz,   'changed', 'default can be overriden';
is $foo->bazed, 'none',    'default can be overriden';
