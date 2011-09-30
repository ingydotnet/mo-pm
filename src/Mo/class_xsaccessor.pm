package Mo::class_xsaccessor;
my $MoPKG = "Mo::";
$VERSION = 0.25;

require Class::XSAccessor;

*{$MoPKG.'class_xsaccessor::e'} = sub {
    my ($caller_pkg, $exports, $handlers, $features) = @_;
    $caller_pkg =~ s/::$//;
    $exports->{has} = sub {
        my ( $name, %args ) = @_;
        Class::XSAccessor->import(
          class => $caller_pkg,
          accessors => { $name => $name }
        );
    } unless grep !/class_xsaccessor/, @$features;
};
