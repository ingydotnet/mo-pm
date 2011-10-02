package Mo::xs;my$K="Mo::";
$VERSION=0.25;
require Class::XSAccessor;*{$K.'class_xsaccessor::e'}=sub{my($P,$e)=@_;$P=~s/::$//;$e->{has}=sub{my($n,%a)=@_;Class::XSAccessor->import(class=>$P,accessors=>{$n=>$n})}};
