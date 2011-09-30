package Mo::build;my$K="Mo::";
$VERSION=0.25;
*{$K.'build::e'}=sub{my($P,$h,$e)=@_;$e->{new}=sub{$c=shift;my$s=bless{@_},$c;my@B;do{@B=($c.::BUILD,@B)}while($c)=@{$c.::ISA};exists&$_&&&$_($s)for@B;$s}};
