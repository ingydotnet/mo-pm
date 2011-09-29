package Mo::default;
my $MoPKG = "Mo::";
$VERSION = 0.25;

*{$MoPKG.'default::e'} = sub {
    my $caller_pkg = shift;
    my %exports = @_;
    my $old_export = $exports{has};
    $exports{has} = sub {
        my ( $name, %args ) = @_;
        my $default = $args{default}
          or return $old_export->(@_);
        *{ $caller_pkg . $name } =
            sub {
                $#_
                  ? $_[0]{$name} = $_[1]
                    : ! exists $_[0]{$name}
                      ? $_[0]{$name} = $_[0]->$default
                      : $_[0]{$name}
            };
    };
    %exports;
};
