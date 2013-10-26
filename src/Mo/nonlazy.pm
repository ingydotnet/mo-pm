package Mo::nonlazy;
my $MoPKG = "Mo::";
$VERSION=0.38;

*{ $MoPKG . 'nonlazy::e' } = sub {
    ${ shift . NONLAZY } = 1;
};
