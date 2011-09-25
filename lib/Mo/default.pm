package Mo::default;
# use strict;

$YAML::DumpCode = 1;
sub e {
    my $P = shift;
    my %s = @_;
    my $h = $s{has};
    $s{has} = sub {
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
            : $h->($n);
    };
    %s;
}

1;
