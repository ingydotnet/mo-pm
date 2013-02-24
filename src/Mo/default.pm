package Mo::default;
my $MoPKG = "Mo::";
$VERSION = 0.31;

*{$MoPKG.'default::e'} = sub {
    my ($caller_pkg, $exports, $options) = @_;
    $options->{default} = sub {
        my ($method, $name, %args) = @_;
        exists $args{default} or return $method;
        die $name.' not a code ref' if ref($args{default}) ne 'CODE';
        sub {
            $#_
              ? $method->(@_)
                : ! exists $_[0]{$name}
                    ? $_[0]{$name} = $args{default}->(@_)
                    : $method->(@_)
        };
    };
};
