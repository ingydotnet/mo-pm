package Mo::builder;package Mo;$K = __PACKAGE__;

*{$K.'::builder::e'} = sub {
    my $P = shift;
    my %s = @_;
    my $h = $s{has};
    $s{has} = sub {
        my ( $n, %a ) = @_;
        my $b = $a{builder};
        *{ $P . "::$n" } = $b
            ? sub {
                $#_
                  ? $_[0]{$n} = $_[1]
                    : ! exists $_[0]{$n}
                      ? $_[0]{$n} = $_[0]->$b
                      : $_[0]{$n}
            }
            : $h->(@_);
    };
    %s;
}
