package Mo::build;
my $MoPKG = "Mo::";
$VERSION = 0.30;

my $use_subname = eval { require Sub::Name; 1 };

*{$MoPKG.'build::e'} = sub {
    my ($caller_pkg, $exports) = @_;
    my $new = sub {
        my $class = shift;
        my $self = bless {@_}, $class;
        my @build_subs;

        do {
            @build_subs = ($class . ::BUILD, @build_subs)
        }
        while ($class) = @{ $class . ::ISA };

        exists &$_ && &$_( $self ) for @build_subs;
        $self;
    };
    $exports->{new} = (
        $use_subname ?
        Sub::Name::subname($caller_pkg.'new' => $new)
        : $new
    );
};
