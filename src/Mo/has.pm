package Mo::has;;package Mo;$K = __PACKAGE__;
use Mo::default;
use Mo::builder;
$VERSION = 0.24;

*{$K.'::has::e'} = sub {
    my $p = shift;
    &{$K.'::builder::e'}($p,
    &{$K.'::default::e'}($p, @_));
};
