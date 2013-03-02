package Mo::nonlazy;
my $MoPKG = "Mo::";
$VERSION = 0.33;

*{ $MoPKG . 'nonlazy::e' } = sub {
    ${ shift . O } = 1;
};
