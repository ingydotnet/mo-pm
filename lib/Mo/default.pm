package Mo::default;$K="Mo::";
$VERSION=0.24;
*{$K.'default::e'}=sub{my($P,$p,$e)=@_;$p->{default}=sub{my($m,$n,%a)=@_;$a{default}or return$m;sub{$#_?$m->(@_):!exists$_[0]{$n}?$_[0]{$n}=$a{default}->(@_):$m->(@_)}}};
