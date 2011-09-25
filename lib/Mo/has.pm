package Mo::has;
use Mo::builder;
use Mo::default;

sub e {
    my $p = shift;
    my @e = Mo::default::e($p, @_);
    Mo::builder::e($p, @e);
}

1;
