package Mo::importer;
my $MoPKG = "Mo::";
$VERSION = 0.30;

*{$MoPKG.'importer::e'} = sub {
    my ($caller_pkg, $exports, $options, $features) = @_;
    (my $pkg = $caller_pkg) =~ s/::$//;
    &{$caller_pkg.'importer'}($pkg, @$features)
        if defined &{$caller_pkg.'importer'};
};
