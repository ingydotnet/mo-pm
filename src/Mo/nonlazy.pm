package Mo::nonlazy;
my $MoPKG = "Mo::";
$VERSION = 0.33;

*{ $MoPKG . 'nonlazy::e' } = sub {
    ${ shift . NONLAZY } = 1;
};
