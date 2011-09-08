package Mo;

our $VERSION = '0.11';

sub import {
    my $p = caller;
    my %m = (
        new     => sub { bless { @_[ 1 .. $#_ ] }, $_[0] },
        extends => sub { @{ (caller) . '::ISA' } = $_[0] },
        has     => sub {
            my $n = $_[0];
            *{ (caller) . "::$n" } = sub {
                @_ - 1 ? $_[0]{$n} = $_[1] : $_[0]{$n};
            };
        },
    );
    *{$p."::$_"} = $m{$_} for keys %m;
    push @{ $p . '::ISA' }, $_[0];
}

1;
