use TestML -run;
use xt::TestClass;
my $debug = 0;

sub count_ops {
    my $test = (shift)->value;
    my $cmd = "perl -MO=Concise,-nobanner,-exec -e '$test' 2>/dev/null";
    my @lines = `$cmd`;
    warn join '', @lines if $debug;
    return @lines;
}

__DATA__
%TestML 1.0

Plan = 4;

*test.count_ops == *count;

=== Getting an undefined bare accessor
--- test: $t->bare
--- count: 7

=== Setting an undefined bare accessor
--- test: $t->bare("set")
--- count: 8

=== Setting an set bare accessor
--- test: $t->bare()
--- count: 7

=== Getting a defaulting accessor
--- test: $t->default()
--- count: 7

