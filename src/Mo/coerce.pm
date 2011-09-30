package Mo::coerce;$MoPKG = "Mo::";
$VERSION = 0.24;

*{$MoPKG.'coerce::e'} = sub {
    my ($caller_pkg, $params, $exports) = @_;
    $params->{coerce} = sub {
        my ($method, $name, %args) = @_;
        $args{coerce} or return $method;
        sub {
            $#_
              ? $method->($_[0], $args{coerce}->($_[1]))
                : $method->(@_)
        };
    };
    $exports->{new} = sub {
        my ($class, %args) = @_;
        my $self = bless {%args}, $class;
        $self->$_($args{$_}) for keys %args;
        $self;
    };
};
