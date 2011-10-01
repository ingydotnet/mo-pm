package Mo::builder;
my $MoPKG = "Mo::";
$VERSION = 0.25;

*{$MoPKG.'builder::e'} = sub {
    my ($caller_pkg, $exports, $options) = @_;
    my $e_caller = caller;
    $options->{builder} = sub {
        my ($method, $name, %args) = @_;
        my $builder = $args{builder} or return $method;
        $builder = "_build_".$name if $builder eq '1' && $e_caller eq 'Mo::autobuild';
        sub {
            $#_
              ? $method->(@_)
                : ! exists $_[0]{$name}
                    ? $_[0]{$name} = $_[0]->$builder
                    : $method->(@_)
        };
    };
};
