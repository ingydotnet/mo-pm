package Mo; require strict; require warnings;
our $VERSION = '0.13';
sub import {
    strict->import; warnings->import; my $p = caller; @{$p.'::ISA'} = $_[0];
    *{$p.'::extends'} = sub {@{(caller).'::ISA'} = $_[0]};
    *{$p.'::has'} = sub { my ($n, %a) = @_; *{(caller)."::$n"} = $a{default}
        ? sub { $#_ ? ($_[0]{$n} = $_[1]) : (exists $_[0]{$n})
                ? $_[0]{$n} : ($_[0]{$n} = $a{default}($_[0])) }
        : sub { $#_ ?  $_[0]{$n} = $_[1] : $_[0]{$n} } };
} sub new { my $s = bless {@_[1..$#_]},$_[0];$s->can('BUILD') && $s->BUILD;$s}
