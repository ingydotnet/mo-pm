package Mo::class_xsaccessor;package Mo;$K=__PACKAGE__."::";
$VERSION=0.24;
require Class::XSAccessor;*{$K.'class_xsaccessor::e'}=sub{my$P=shift;$P=~s/::$//;my%e=@_;$e{has}=sub{my($n)=@_;Class::XSAccessor->import(class=>$P,accessors=>{$n=>$n})};%e};
