package Mo::autobuild;package Mo;$K=__PACKAGE__."::";use Mo::builder;
$VERSION=0.24;
*{$K.'autobuild::e'}=sub{my$P=shift;my%e=&{$K.'builder::e'}($P,@_);my$o=$e{has};$e{has}=sub{my($n,%a)=@_;$a{builder}="_build_$name"if$a{builder}==1;*{$P.$n}=$o->(@_,%a)};%e};
