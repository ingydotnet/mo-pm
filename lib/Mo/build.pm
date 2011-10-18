package Mo::build;my$M="Mo::";
$VERSION=0.30;
my$use_subname=eval{require Sub::Name;1 };*{$M.'build::e'}=sub{my($P,$e)=@_;my$new=sub{my$c=shift;my$s=bless{@_},$c;my@B;do{@B=($c.::BUILD,@B)}while($c)=@{$c.::ISA};exists&$_&&&$_($s)for@B;$s};$e->{new}=($use_subname?Sub::Name::subname($P.'new'=>$new):$new)};
