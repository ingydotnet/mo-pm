package Mo::default;

sub e {
    my $P = shift;
    my %s = @_;
    my $h = $s{has};
    $s{has} = sub {
        my ( $n, %a ) = @_;
        my $d = $a{default};
        *{ $P . "::$n" } = $d
            ? sub {
                $#_
                  ? $_[0]{$n} = $_[1]
                    : ! exists $_[0]{$n}
                      ? $_[0]{$n} = $_[0]->$d
                      : $_[0]{$n}
            }
            : $h->(@_);
    };
    %s;
}

1;
