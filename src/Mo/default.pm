package Mo::default;
my $MoPKG = "Mo::";
$VERSION = 0.33;

*{$MoPKG.'default::e'} = sub {
    my ($caller_pkg, $exports, $options) = @_;
    $options->{default} = sub {
        my ($method, $name, %args) = @_;
        exists $args{default} or return $method;

        my ( $default, $reftype ) = $args{default};
        my $generator =
            'HASH' eq ( $reftype = ref $default ) ? sub { +{%$default} }
          : 'ARRAY' eq $reftype ? sub { [@$default] }
          : 'CODE'  eq $reftype ? $default
          :                       sub { $default };
        sub {
            $#_                      ? $method->(@_)
              : !exists $_[0]{$name} ? $_[0]{$name} =
                $generator->(@_)
              : $method->(@_);
        };
    };
};
