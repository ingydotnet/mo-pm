package Mo::has;
$VERSION = 0.24;
package Mo;$MoPKG = __PACKAGE__."::";
use Mo::default;
use Mo::builder;

*{$MoPKG.'has::e'} = sub {
    my $caller_pkg = shift;
    &{$MoPKG.'builder::e'}($caller_pkg,
    &{$MoPKG.'default::e'}($caller_pkg, @_));
};
