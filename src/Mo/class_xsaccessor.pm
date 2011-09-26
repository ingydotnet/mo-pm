package Mo::class_xsaccessor;package Mo;$MoPKG = __PACKAGE__."::";
$VERSION = 0.24;

require Class::XSAccessor;

*{$MoPKG.'class_xsaccessor::e'} = sub {
    my $caller_pkg = shift;
    $caller_pkg =~ s/::$//;
    my %exports = @_;
    $exports{has} = sub {
        my ( $name ) = @_;
        Class::XSAccessor->import(
          class => $caller_pkg,
          accessors => { $name => $name }
        );
    };
    %exports;
};
