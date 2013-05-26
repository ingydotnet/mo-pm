package Mo::build;
my $MoPKG = "Mo::";
$VERSION = 0.34;

*{$MoPKG.'build::e'} = sub {
    my ($caller_pkg, $exports) = @_;
    $exports->{new} = sub {
        $class = shift;
        my $self = &{$MoPKG.Object::new}($class,@_);

        my @build_subs;

        do {
            @build_subs = ($class . ::BUILD, @build_subs)
        }
        while ($class) = @{ $class . ::ISA };

        exists &$_ && &$_( $self ) for @build_subs;
        $self;
    };
};
