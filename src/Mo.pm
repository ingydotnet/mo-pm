package Mo;
$VERSION = 0.24;

no warnings;
my $K = __PACKAGE__;

*{$K.'::Object::new'} = sub {
    my $c = shift;
    my $s = bless {@_}, $c;
    my @c;

    do {
        @c = ($c . '::BUILD', @c)
    }
    while ($c) = @{ $c . '::ISA' };

    exists &$_ && &$_($s)
        for @c;

    $s;
};

*{$K.'::import'} = sub {
    import warnings;
    $^H |= 1538;
    my $P = caller;
    my %s = (
        extends => sub {
            eval "no $_[0] ()";
            @{ $P . '::ISA' } = $_[0];
        },
        has => sub {
            my $n = shift;
            *{ $P . "::$n" } =
                sub {
                    $#_
                        ? $_[0]{$n} = $_[1]
                        : $_[0]{$n};
                };
        },
    );
    for (@_[1..$#_]) {
        eval "require Mo::$_;1" or die $@;
        %s = &{"Mo::${_}::e"}($P => %s);
    }
    *{ $P . "::$_"} = $s{$_} for keys %s;
    @{ $P . '::ISA' } = $K.'::Object';
};
