use Test::More tests => 2;

{
    package Mo::Standard;
    use Mo qw(default);
    has name => 'Ayrton Senna';

    has sport => { F1 => 'F1' }, lazy => 1;
    has teams => [ 'McLaren', 'Lotus', 'Toleman', 'Williams' ], lazy => 0;
    has no_teams => sub { scalar @{ shift->teams } }, lazy => 1;
    has championships => sub { [ 1988, 1990, 1991 ] }, lazy => 0;
}
{
    package Moose::Alike;
    use Mo qw(default build);
    has name => 'Ayrton Senna';

    has sport => { F1 => 'F1' }, lazy => 1;
    has teams => [ 'McLaren', 'Lotus', 'Toleman', 'Williams' ], lazy => 0;
}

package main;

subtest "Standard behavior" => sub {
    my $standard = Mo::Standard->new;
    is( $standard->{name}, undef,          'attributes are lazy by default' );
    is( $standard->name,   'Ayrton Senna', 'initialized lazily' );
    is( $standard->{sport}, undef, 'attr is lazy when explicitly asked' );
    is_deeply( $standard->sport, { F1 => 'F1' }, 'initialized lazily' );
    is_deeply(
        $standard->{teams},
        [ 'McLaren', 'Lotus', 'Toleman', 'Williams' ],
        'attr is non lazy when explicitly asked'
    );
    is_deeply(
        $standard->teams,
        [ 'McLaren', 'Lotus', 'Toleman', 'Williams' ],
        'accessor on non lazy'
    );
    is( $standard->no_teams, 4, 'non lazy attribute' );
    is_deeply(
        $standard->{championships},
        [ 1988, 1990, 1991 ],
        'not lazy when explicitly asked'
    );
};

subtest "Moose-like behavior (importing nonlazy)" => sub {
    my $moosey = Moose::Alike->new;
    is( $moosey->{name}, 'Ayrton Senna',
        'importing nonlazy makes attributes default to non lazy' );
    is( $moosey->name,    'Ayrton Senna', 'attribute accessor' );
    is( $moosey->{sport}, undef,          'lazy when explicitly asked' );
    is_deeply( $moosey->sport, { F1 => 'F1' }, 'lazy default' );
    is_deeply(
        $moosey->{teams},
        [ 'McLaren', 'Lotus', 'Toleman', 'Williams' ],
        'not lazy when explicitly asked'
    );
    is_deeply(
        $moosey->teams,
        [ 'McLaren', 'Lotus', 'Toleman', 'Williams' ],
        'attribute accessor'
    );
};
