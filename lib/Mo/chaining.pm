package Mo::chaining;
my $MoPKG = "Mo::";
$VERSION = 0.26;

*{$MoPKG.'chaining::e'} = sub {
    my ($caller_pkg, $exports, $options) = @_;
    $options->{chaining} = sub {
        my ($method, $name, %args) = @_;
        $args{chaining} or return $method;
        sub {
            $#_ ? ($method->(@_) and return $_[0]) : $method->(@_);
        };
    };
};
