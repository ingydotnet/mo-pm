package Mo::default;my$K="Mo::";
$VERSION=0.25;
*{$K.'default::e'}=sub{my($P,$e,$h)=@_;$h->{default}=sub{my($m,$n,%a)=@_;$a{default}or return$m;sub{$#_?$m->(@_):!exists$_[0]{$n}?$_[0]{$n}=$a{default}->(@_):$m->(@_)}}};
