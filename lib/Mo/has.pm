package Mo::has;;package Mo;$K = __PACKAGE__;
use Mo::default;
use Mo::builder;

*{$K.'::has::e'} = sub {
    my $p = shift;
    &{$K.'::builder::e'}($p,
    &{$K.'::default::e'}($p, @_));
}
