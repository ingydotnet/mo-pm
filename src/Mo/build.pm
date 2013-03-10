package Mo::build;
my $MoPKG = "Mo::";
$VERSION = 0.33;

*{$MoPKG.'build::e'} = sub {
    my ($caller_pkg, $exports) = @_;
    ${ $caller_pkg . NONLAZY } = 1;
    $exports->{new} = sub {
        $class = shift;
        my $self = bless {@_}, $class;

        my %nonlazy_defaults = %{ $class . :: . EAGERINIT };
        map { $self->{$_} = $nonlazy_defaults{$_}->() if !exists $self->{$_} }
          keys %nonlazy_defaults;

        my @build_subs;

        do {
            @build_subs = ($class . ::BUILD, @build_subs)
        }
        while ($class) = @{ $class . ::ISA };

        exists &$_ && &$_( $self ) for @build_subs;
        $self;
    };
};
