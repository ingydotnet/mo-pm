package Mo::default;package Mo;$MoPKG = __PACKAGE__;
$VERSION = 0.24;

*{$MoPKG.'::default::e'} = sub {
    my $caller_pkg = shift;
    my %exports = @_;
    my $old_export = $exports{has};
    $exports{has} = sub {
        my ( $name, %args ) = @_;
        my $default = $args{default};
        *{ $caller_pkg . "::".$name } = $default
            ? sub {
                $#_
                  ? $_[0]{$name} = $_[1]
                    : ! exists $_[0]{$name}
                      ? $_[0]{$name} = $_[0]->$default
                      : $_[0]{$name}
            }
            : $old_export->(@_);
    };
    %exports;
};
