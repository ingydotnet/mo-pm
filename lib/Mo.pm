package Mo;
$VERSION=0.25;
no warnings;my$K=__PACKAGE__.::;*{$K.Object::new}=sub{$c=shift;my$s=bless{@_},$c;my@B;do{@B=($c.::BUILD,@B)}while($c)=@{$c.::ISA};exists&$_&&&$_($s)for@B;$s};*{$K.import}=sub{import warnings;$^H|=1538;my$P=caller.::;my%e=(extends,sub{eval"no $_[0]()";@{$P.ISA}=$_[0]},has,sub{my$n=shift;*{$P.$n}=sub{$#_?$_[0]{$n}=$_[1]:$_[0]{$n}}},ISA,\$K.Object);shift;eval"no Mo::$_",%e=&{$K.$_.::e}($P,%e)for@_;*{$P.$_}=$e{$_}for keys%e};
