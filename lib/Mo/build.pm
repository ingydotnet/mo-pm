package Mo::build;package Mo;$K=__PACKAGE__."::";
$VERSION=0.24;
*{$K.'build::e'}=sub{my$P=shift;my%e=@_;$e{new}=sub{$c=shift;my$s=bless{@_},$c;my@B;do{@B=($c.::BUILD,@B)}while($c)=@{$c.::ISA};exists&$_&&&$_($s)for@B;$s};%e};
