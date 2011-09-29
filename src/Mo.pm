package Mo;
$VERSION = 0.25;

no warnings;
my $MoPKG = __PACKAGE__.::;

*{$MoPKG.Object::new} = sub {
    bless {@_[1..$#_]}, $_[0];
};

*{$MoPKG.import} = sub {
    import warnings;
    $^H |= 1538;
    my $caller_pkg = caller.::;
    my %exports = (
        extends, sub {
            eval "no $_[0]()";
            @{ $caller_pkg . ISA } = $_[0];
        },
        has, sub {
            my $name = shift;
            *{ $caller_pkg . $name } =
                sub {
                    $#_
                        ? $_[0]{$name} = $_[1]
                        : $_[0]{$name};
                };
        },
    );
    shift;
    eval "no Mo::$_", %exports = &{$MoPKG.$_.::e}($caller_pkg, %exports) for @_;
    *{ $caller_pkg . $_} = $exports{$_} for keys %exports;
    @{ $caller_pkg . ISA } = $MoPKG.Object;
};
