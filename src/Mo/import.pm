package Mo::import;
my $MoPKG = "Mo::";
$VERSION = 0.25;

my $import = \&import;
*{$MoPKG.import} = sub {
    if (@_ == 2 and not $_[1]) {
        pop @_;
    }
    elsif (@_ == 1) {
        push @_, grep !/import/, @features;
    }
    goto &$import;
};
