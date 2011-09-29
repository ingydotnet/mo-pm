package Mo::builder;$MoPKG = "Mo::";
$VERSION = 0.24;

*{$MoPKG.'builder::e'} = sub {
    my $caller_pkg = shift;
    my %exports = @_;
    my $old_export = $exports{has};
    $exports{has} = sub {
        my ( $name, %args ) = @_;
        my $builder = $args{builder}
          or return $old_export->(@_);
        *{ $caller_pkg . $name } = 
          sub {
                $#_
                  ? $_[0]{$name} = $_[1]
                    : ! exists $_[0]{$name}
                      ? $_[0]{$name} = $_[0]->$builder
                      : $_[0]{$name}
          };
    };
    %exports;
};
