package Mo::chain;
my $MoPKG = "Mo::";
$VERSION = 0.30;

*{$MoPKG.'chain::e'} = sub {
    my ($caller_pkg, $exports, $options) = @_;
    $options->{chain} = sub {
        my ($method, $name, %args) = @_;
        $args{chain} or return $method;
        sub {
            $#_ ? ($method->(@_), return $_[0]) : $method->(@_);
        };
    };
};
