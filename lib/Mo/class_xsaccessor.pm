package Mo::class_xsaccessor;
$VERSION=0.24;
package Mo;$K=__PACKAGE__."::";require Class::XSAccessor;*{$K.'class_xsaccessor::e'}=sub{my($P,$p,$e,$f)=@_;$P=~s/::$//;$e->{has}=sub{my($n,%a)=@_;Class::XSAccessor->import(class=>$P,accessors=>{$n=>$n})}unless grep!/class_xsaccessor/,@$f};
