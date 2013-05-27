package Mo::nonlazy;
my $MoPKG = "Mo::";
$VERSION = 0.35;

*{ $MoPKG . 'nonlazy::e' } = sub {
    ${ shift . NONLAZY } = 1;
};
