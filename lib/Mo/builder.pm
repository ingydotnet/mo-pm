package Mo::builder;my$M="Mo::";
$VERSION=0.25;
*{$M.'builder::e'}=sub{my($P,$e,$o)=@_;my$l=caller;$o->{builder}=sub{my($m,$n,%a)=@_;my$b=$a{builder}or return$m;$b="_build_$name"if($b)eq '1'&&($l)eq 'Mo::autobuild';sub{$#_?$m->(@_):!exists$_[0]{$n}?$_[0]{$n}=$_[0]->$b:$m->(@_)}}};
