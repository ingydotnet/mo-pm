package Mo::xs;
my $MoPKG = "Mo::";
$VERSION = 0.31;

require Class::XSAccessor;

*{$MoPKG.'xs::e'} = sub {
    my ($caller_pkg, $exports, $options, $features) = @_;
    $caller_pkg =~ s/::$//;
    $exports->{has} = sub {
        my ( $name, %args ) = @_;
        Class::XSAccessor->import(
            class => $caller_pkg,
            accessors => { $name => $name }
        );
    } if ! grep !/^xs$/, @$features;
};
