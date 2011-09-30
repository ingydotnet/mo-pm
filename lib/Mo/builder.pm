package Mo::builder;my$K="Mo::";
$VERSION=0.25;
*{$K.'builder::e'}=sub{my($P,$p,$e)=@_;$p->{builder}=sub{my($m,$n,%a)=@_;my$b=$a{builder}or return$m;sub{$#_?$m->(@_):!exists$_[0]{$n}?$_[0]{$n}=$_[0]->$b:$m->(@_)}}};
