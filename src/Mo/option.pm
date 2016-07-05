package Mo::option;
my $MoPKG = "Mo::";
$VERSION='0.40';

*{$MoPKG.'option::e'} = sub {
    my ($caller_pkg, $exports, $options) = @_;
    $options->{option} = sub {
        my ($method, $name, %args) = @_;
        $args{option} or return $method;
        my $n2 = $name;
        *{$caller_pkg."read_$n2"} = sub {
            $_[0]->{$n2};
        };
        sub {
            $#_
                ? $method->(@_)
                : $method->(@_, 1);
            $_[0];
        };
    };
};
