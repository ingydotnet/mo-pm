package Mo::exporter;
my $MoPKG = "Mo::";
$VERSION = 0.29;

*{$MoPKG.'exporter::e'} = sub {
    my ($caller_pkg) = @_;
    if (defined @{$MoPKG.EXPORT}) {
        *{$caller_pkg.$_} = \&{$MoPKG.$_}
            for @{$MoPKG.EXPORT};
    };
};
