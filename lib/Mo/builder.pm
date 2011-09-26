package Mo::builder;package Mo;$K=__PACKAGE__;
$VERSION=0.24;
*{$K.'::builder::e'}=sub{my$P=shift;my%e=@_;my$o=$e{has};$e{has}=sub{my($n,%a)=@_;my$b=$a{builder};*{$P."::".$n}=$b?sub{$#_?$_[0]{$n}=$_[1]:!exists$_[0]{$n}?$_[0]{$n}=$_[0]->$b:$_[0]{$n}}:$o->(@_)};%e};
