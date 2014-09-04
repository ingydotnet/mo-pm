package Mo::import;
my $MoPKG = "Mo::";
$VERSION=0.39;

my $import = \&import;
*{$MoPKG.import} = sub {
    (@_ == 2 and not $_[1])
    ? pop @_
    : @_ == 1
        ? push @_, grep !/import/, @features
        : ();
    goto &$import;
};
