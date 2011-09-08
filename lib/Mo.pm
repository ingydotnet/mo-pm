package Mo;

our $VERSION = '0.11';

sub import {
    my $p = caller;
    *{$p.'::extends'} = sub { @{caller.'::ISA'} = $_[0] };
    *{$p.'::has'} = sub {
        my $n = $_[0];
        *{caller."::$n"} = sub { @_-1 ? $_[0]->{$n} = $_[1] : $_[0]->{$n} };
    };
    push @{$p.'::ISA'}, $_[0];
}

sub new { $_ = bless { @_[1..$#_] }, $_[0]; $_->can('BUILD') && $_->BUILD; $_ }

1;
