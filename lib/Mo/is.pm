package Mo::is;$K="Mo::";
$VERSION=0.25;
*{$K.'is::e'}=sub{my($P,$h,$e)=@_;$h->{is}=sub{my($m,$n,%a)=@_;$a{is}or return$m;sub{$#_&&$a{is}eq 'ro'?die:$m->(@_)}}};
