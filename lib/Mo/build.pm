package Mo::build;
$VERSION=0.24;
package Mo;$K=__PACKAGE__."::";*{$K.'build::e'}=sub{my($P,$p,$e)=@_;$e->{new}=sub{$c=shift;my$s=bless{@_},$c;my@B;do{@B=($c.::BUILD,@B)}while($c)=@{$c.::ISA};exists&$_&&&$_($s)for@B;$s}};
