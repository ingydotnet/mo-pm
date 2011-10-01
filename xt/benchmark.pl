use strict;
use warnings;
use Benchmark qw(:all) ;

my ($num, $count, @keys) = (1, @ARGV);

my $tests = {
    map {
        my $t = $_;
        my $l = lc($t);
        eval <<"...";
package $l;
use $t;
has good => (is => 'ro');
has bad => (is => 'ro');
has ugly => (is => 'rw');
...
        my $v = do { no strict 'refs'; ${$t."::VERSION"} };
        ($l => [ "$t $v"  =>
            sub {
                my $m = $l->new(good => 'Perl', bad => 'Python', ugly => 'Ruby');
                $m->good;
                $m->bad;
                $m->ugly;
                $m->ugly('Bunny');
            }
        ])
    } qw(Mo Moo Mouse Moose)
};

timethese($count, {
    map {
        (
            $num++ . ") $_->[0]",
            $_->[1]
        )
    } map $tests->{$_}, @keys
});
