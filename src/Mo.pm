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
    shift;
    my (%exports, %handlers);
    eval "no Mo::$_", &{$MoPKG.$_.::e}($caller_pkg, \%exports, \%handlers, \@_) for @_;
    %exports = (
        extends, sub {
            eval "no $_[0]()";
            @{ $caller_pkg . ISA } = $_[0];
        },
        has, sub {
            my $name = shift;
            my $method =
                sub {
                    $#_
                        ? $_[0]{$name} = $_[1]
                        : $_[0]{$name};
                };
            $method = $handlers{$_}->($method, $name, @_) for keys %handlers;
            *{ $caller_pkg . $name } = $method;
        },
        %exports,
    );
    *{ $caller_pkg . $_} = $exports{$_} for keys %exports;
    @{ $caller_pkg . ISA } = $MoPKG.Object;
};
