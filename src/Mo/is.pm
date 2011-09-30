package Mo::is;$MoPKG = "Mo::";
$VERSION = 0.25;

*{$MoPKG.'is::e'} = sub {
    my ($caller_pkg, $exports, $handlers) = @_;
    $handlers->{is} = sub {
        my ($method, $name, %args) = @_;
        $args{is} or return $method;
        sub {
            $#_ && $args{is} eq 'ro' && caller ne 'Mo::coerce'
              ? die 
                : $method->(@_)
        };
    };
};
