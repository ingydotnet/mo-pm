package Mo::class_xsaccessor;my$K="Mo::";
$VERSION=0.25;
require Class::XSAccessor;*{$K.'class_xsaccessor::e'}=sub{my($P,$e,$h,$features)=@_;$P=~s/::$//;$e->{has}=sub{my($n,%a)=@_;Class::XSAccessor->import(class=>$P,accessors=>{$n=>$n})}unless grep!/class_xsaccessor/,@$features};
