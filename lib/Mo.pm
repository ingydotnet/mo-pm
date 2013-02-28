package Mo;
$VERSION='0.33';
no warnings;my$M=__PACKAGE__.'::';*{$M.Object::new}=sub{my$K=shift;my$Z=bless{@_},$K;my%x=%{$K.'::E'};map{$Z->{$_}=$x{$_}->()if!exists$Z->{$_}}keys%x;$Z};*{$M.import}=sub{import warnings;$^H|=1538;my($P,%e,%o)=caller.'::';shift;eval"no Mo::$_",&{$M.$_.::e}($P,\%e,\%o,\@_)for@_;return if$e{M};%e=(extends,sub{eval"no $_[0]()";@{$P.ISA}=$_[0]},has,sub{my$n=shift;my$m=sub{$#_?$_[0]{$n}=$_[1]:$_[0]{$n}};@_=(default,@_)if!($#_%2);$m=$o{$_}->($m,$n,@_)for sort keys%o;*{$P.$n}=$m},%e,);*{$P.$_}=$e{$_}for keys%e;@{$P.ISA}=$M.Object};
