package Mo::default;

sub e {
    my $P = shift;
    my %s = @_;
    %{{
        @_,
        has => sub {
            my ( $n, %a ) = @_;
            my $d = $a{default}||$a{builder};
            *{ $P . "::$n" } = $d
                ? sub {
                    $#_
                      ? $_[0]{$n} = $_[1]
                        : ! exists $_[0]{$n}
                          ? $_[0]{$n} = $_[0]->$d
                          : $_[0]{$n}
                }
# XXX This code is duplicated from Mo. Should be wrapped somehow.
                : sub {
                    $#_
                        ? $_[0]{$n} = $_[1]
                        : $_[0]{$n};
                };
        },
    }};
}

1;
