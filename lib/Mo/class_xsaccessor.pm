package Mo::class_xsaccessor;package Mo;$K=__PACKAGE__."::";
$VERSION=0.24;
require Class::XSAccessor;*{$K.'class_xsaccessor::e'}=sub{my$P=shift;$P=~s/::$//;my%e=@_;my$o=$e{has};$e{has}=sub{my($n,%a)=@_;$a{default}||$a{builder}and return$o->(@_);Class::XSAccessor->import(class=>$P,accessors=>{$n=>$n})};%e};
