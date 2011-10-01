package Mo::autobuild;
my $MoPKG = "Mo::";
$VERSION = 0.25;

no Mo::builder;

*{$MoPKG.'autobuild::e'} = sub {
    &{$MoPKG.'builder::e'}(@_);
};
