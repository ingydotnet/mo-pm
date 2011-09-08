package Mo;

our $VERSION = '0.11';

sub import {
    my $p = caller;
    *{$p.'::new'} = sub { bless { @_[1..$#_] }, $p };
    *{$p.'::extends'} = sub { @{caller.'::ISA'} = $_[0] };
    *{$p.'::has'} = sub {
        my $n = $_[0];
        *{caller."::$n"} = sub { @_-1 ? $_[0]->{$n} = $_[1] : $_[0]->{$n} };
    };
    push @{$p.'::ISA'}, $_[0];
}

1;
