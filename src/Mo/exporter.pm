package Mo::exporter;
my $MoPKG = "Mo::";
$VERSION = 0.26;

*{$MoPKG.'exporter::e'} = sub {
    my ($caller_pkg, $exports) = @_;
    @{$MoPKG.EXPORT};
    if (defined @{$MoPKG.EXPORT}) {
        *{$caller_pkg.$_} = \&{$MoPKG.$_}
            for @{$MoPKG.EXPORT};
    };
};
