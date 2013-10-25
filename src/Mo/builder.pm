package Mo::builder;
my $MoPKG = "Mo::";
$VERSION=0.37;

*{$MoPKG.'builder::e'} = sub {
    my ($caller_pkg, $exports, $options) = @_;
    $options->{builder} = sub {
        my ($method, $name, %args) = @_;
        my $builder = $args{builder} or return $method;

        my $is_lazy = exists $args{lazy} ? $args{lazy} : !${$caller_pkg.NONLAZY};
        $is_lazy or ${ $caller_pkg . EAGERINIT }{$name} = \&{$caller_pkg.$builder} and return $method;

        sub {
            $#_
              ? $method->(@_)
                : ! exists $_[0]{$name}
                    ? $_[0]{$name} = $_[0]->$builder
                    : $method->(@_)
        };
    };
};
