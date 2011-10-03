package Mo::xs;my$M="Mo::";
$VERSION=0.25;
require Class::XSAccessor;*{$M.'xs::e'}=sub{my($P,$e,$o,$features)=@_;$P=~s/::$//;$e->{has}=sub{my($n,%a)=@_;Class::XSAccessor->import(class=>$P,accessors=>{$n=>$n})}unless grep /^xs$/,@$features};
