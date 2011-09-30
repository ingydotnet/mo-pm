package Mo::coerce;
my $MoPKG = "Mo::";
$VERSION = 0.25;

*{$MoPKG.'coerce::e'} = sub {
    my ($caller_pkg, $exports, $handlers) = @_;
    $handlers->{coerce} = sub {
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
