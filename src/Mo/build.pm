package Mo::build;
$VERSION = 0.24;
package Mo;$MoPKG = __PACKAGE__."::";

*{$MoPKG.'build::e'} = sub {
    my $caller_pkg = shift;
    my %exports = @_;
    $exports{new} = sub {
        $class = shift;
        my $self = bless {@_}, $class;
        my @build_subs;

        do {
            @build_subs = ($class . ::BUILD, @build_subs)
        }
        while ($class) = @{ $class . ::ISA };

        exists &$_ && &$_( $self ) for @build_subs;
        $self;
    };
    %exports;
};
