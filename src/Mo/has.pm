package Mo::has;
my $MoPKG = "Mo::";
$VERSION = 0.25;
use Mo::default;
use Mo::builder;

*{$MoPKG.'has::e'} = sub {
    my $caller_pkg = shift;
    &{$MoPKG.'builder::e'}($caller_pkg,
    &{$MoPKG.'default::e'}($caller_pkg, @_));
};
