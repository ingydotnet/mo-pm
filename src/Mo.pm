package Mo;
$VERSION = '0.22';
no warnings;

sub import {
    $_->import for strict, warnings;
    my $p = caller."'";
    @{ $p . ISA } = Mo::_;
    *{ $p . extends } =
      sub { @{ $p . ISA } = $_[0]; eval "require $_[0]" };
    *{ $p . has } = sub {
        my ( $n, %a ) = @_;
        my $d = $a{default}||$a{builder};
        *{ $p . $n } = $d
          ? sub {
            $#_ ? ( $_[0]{$n} = $_[1] )
              : exists $_[0]{$n} ? $_[0]{$n}
              : ( $_[0]{$n} = $_[0]->$d )
          }
          : sub { $#_ ? $_[0]{$n} = $_[1] : $_[0]{$n} }
      }
}

sub Mo'_'new {
    my $c = shift;
    my $s = bless {@_}, $c;
    my @c;
    do { unshift @c, $c . "'BUILD" } while $c = ${ $c . "'ISA" }[0];
    defined &$_ && &$_($s) for @c;
    $s
}

no strict
