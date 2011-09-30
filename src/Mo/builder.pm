package Mo::builder;
my $MoPKG = "Mo::";
$VERSION = 0.25;

*{$MoPKG.'builder::e'} = sub {
    my ($caller_pkg, $params, $exports) = @_;
    $params->{builder} = sub {
        my ($method, $name, %args) = @_;
        my $builder = $args{builder} or return $method;
        sub {
            $#_
              ? $method->(@_)
                : ! exists $_[0]{$name}
                    ? $_[0]{$name} = $_[0]->$builder
                    : $method->(@_)
        };
    };
};
