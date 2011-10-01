package Mo::required;my$K="Mo::";
$VERSION=0.25;
*{$K.'required::e'}=sub{my($P,$e,$h)=@_;$h->{required}=sub{my($m,$n,%a)=@_;if($a{required}){my$o=*{$P."new"}{CODE}||*{$K.Object::new}{CODE};no warnings 'redefine';*{$P."new"}=sub{my$s=$o->(@_);my%a=@_[1..$#_];die if!$a{$n};$s}}$m}};
