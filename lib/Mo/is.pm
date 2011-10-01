package Mo::is;$K="Mo::";
$VERSION=0.25;
*{$K.'is::e'}=sub{my($P,$e,$h)=@_;$h->{is}=sub{my($m,$n,%a)=@_;$a{is}or return$m;sub{$#_&&$a{is}eq 'ro'&&caller ne 'Mo::coerce'?die:$m->(@_)}}};
