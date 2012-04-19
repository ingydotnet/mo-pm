package Mo::is;$MoPKG = "Mo::";
$VERSION = 0.30;

*{$MoPKG.'is::e'} = sub {
    my ($caller_pkg, $exports, $options) = @_;
    $options->{is} = sub {
        my ($method, $name, %args) = @_;
        $args{is} or return $method;
        sub {
            $#_ && $args{is} eq 'ro' && caller ne 'Mo::coerce'
              ? die $name.' is ro'
                : $method->(@_)
        };
    };
};
