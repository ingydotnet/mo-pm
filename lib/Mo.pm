package Mo; require strict; require warnings; $Mo::VERSION = '0.15';
sub import {strict->import;warnings->import;my $p=caller;@{$p.'::ISA'}=$_[0];
  *{$p.'::extends'} = sub {@{(caller).'::ISA'} = $_[0];  eval "require $_[0]"};
  *{$p.'::has'} = sub { my ($n, %a) = @_; my($d,$b)=@a{qw(default builder)};
  *{(caller)."::$n"} = $d ? sub { $#_ ? ($_[0]{$n} = $_[1]) : (exists $_[0]{$n})
      ? $_[0]{$n} : ($_[0]{$n} = $d->($_[0])) } :
    $b ? sub { $#_ ? ($_[0]{$n} = $_[1]) : (exists $_[0]{$n})
      ? $_[0]{$n} : ($_[0]{$n} = $_[0]->$b) }
  : sub { $#_ ?  $_[0]{$n} = $_[1] : $_[0]{$n} } };
} sub new {my $s=bless {@_[1..$#_]},$_[0]; $s->can('BUILD')&&$s->BUILD;$s}
