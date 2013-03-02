use Test::More tests => 13;

package Mo::Standard;
use Mo qw(default);
has name => 'Ayrton Senna';

has sport => 'F1',      lazy => 1;
has team  => 'McLaren', lazy => 0;

package Moose::Alike;
use Mo qw(default nonlazy);
has name => 'Ayrton Senna';

has sport => 'F1',      lazy => 1;
has team  => 'McLaren', lazy => 0;

package main;
no warnings 'once';

is( $Mo::Standard::O, undef, 'not importing nonlazy doesnt set package var' );
my $standard = Mo::Standard->new;
is( $standard->{name},  undef,          'attributes are lazy by default' );
is( $standard->name,    'Ayrton Senna', 'lazy default' );
is( $standard->{sport}, undef,          'lazy when explicitly asked' );
is( $standard->sport,   'F1',           'lazy default' );
is( $standard->{team},  'McLaren',      'not lazy when explicitly asked' );

is( $Moose::Alike::O, 1, 'importing nonlazy sets package var' );
my $moosey = Moose::Alike->new;
is( $moosey->{name},  'Ayrton Senna', 'importing nonlazy makes attributes default to non lazy' );
is( $moosey->name,    'Ayrton Senna', 'attribute accessor' );
is( $moosey->{sport}, undef,          'lazy when explicitly asked' );
is( $standard->sport, 'F1',           'lazy default' );
is( $moosey->{team},  'McLaren',      'not lazy when explicitly asked' );
is( $moosey->team,    'McLaren',      'attribute accessor' );
