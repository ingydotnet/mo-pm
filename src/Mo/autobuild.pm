package Mo::autobuild;

package Mo;
$MoPKG = __PACKAGE__ . "::";
use Mo::builder;

$VERSION = 0.24;

*{ $MoPKG . 'autobuild::e' } = sub {
    my $caller_pkg = shift;
    my %exports    = &{ $MoPKG . 'builder::e' }( $caller_pkg, @_ );
    my $old_export = $exports{has};
    $exports{has} = sub {
        my ( $name, %args ) = @_;
        $args{builder} = "_build_$name" if $args{builder} == 1;
        *{ $caller_pkg . $name } = $old_export->( @_, %args ); # this %args will overwrite the one in whatever is the next function
    };
    %exports;
};
