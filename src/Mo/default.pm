package Mo::default;
my $MoPKG = "Mo::";
$VERSION = 0.32;

*{$MoPKG.'default::e'} = sub {
    my ($caller_pkg, $exports, $options) = @_;
    $options->{default} = sub {
        my ($method, $name, %args) = @_;
        exists $args{default} or return $method;

        my $default = $args{default};
        my $gen =
            ref($default) eq 'HASH'  ? sub { +{%$default} }
          : ref($default) eq 'ARRAY' ? sub { [@$default] }
          : ref($default) eq 'CODE'  ? $default
          :                            sub { $default };
        sub {
            $#_                      ? $method->(@_)
              : !exists $_[0]{$name} ? $_[0]{$name} =
                $gen->(@_)
              : $method->(@_);
        };
    };
};
