package Mo::coerce;my$K="Mo::";
$VERSION=0.25;
*{$K.'coerce::e'}=sub{my($P,$e,$h)=@_;$h->{coerce}=sub{my($m,$n,%a)=@_;$a{coerce}or return$m;sub{$#_?$m->($_[0],$a{coerce}->($_[1])):$m->(@_)}};my$o=$e->{new}||*{$K.Object::new}{CODE};$e->{new}=sub{my$s=$o->(@_);$s->$_($s->{$_})for keys%$s;$s}};
