package Mo::coerce;
my $MoPKG = "Mo::";
$VERSION = 0.36;

*{$MoPKG.'coerce::e'} = sub {
    my ($caller_pkg, $exports, $options) = @_;
    $options->{coerce} = sub {
        my ($method, $name, %args) = @_;
        $args{coerce} or return $method;
        sub {
            $#_
              ? $method->($_[0], $args{coerce}->($_[1]))
                : $method->(@_)
        };
    };

    my $old_constructor = $exports->{new} || *{$MoPKG.Object::new}{CODE};
    $exports->{new} = sub {
        my $self = $old_constructor->(@_);
        $self->$_($self->{$_}) for keys %$self;
        $self;
    };
};
