package Mo::default;package Mo;$K=__PACKAGE__;
$VERSION=0.24;
*{$K.'::default::e'}=sub{my$P=shift;my%e=@_;my$o=$e{has};$e{has}=sub{my($n,%a)=@_;my$d=$a{default};*{$P."::".$n}=$d?sub{$#_?$_[0]{$n}=$_[1]:!exists$_[0]{$n}?$_[0]{$n}=$_[0]->$d:$_[0]{$n}}:$o->(@_)};%e};
