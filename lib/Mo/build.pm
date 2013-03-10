package Mo::build;my$M="Mo::";
$VERSION=0.33;
*{$M.'build::e'}=sub{my($P,$e)=@_;${$P.N}=1;$e->{new}=sub{$c=shift;my$s=bless{@_},$c;my%n=%{$c.::.E};map{$s->{$_}=$n{$_}->()if!exists$s->{$_}}keys%n;my@B;do{@B=($c.::BUILD,@B)}while($c)=@{$c.::ISA};exists&$_&&&$_($s)for@B;$s}};
