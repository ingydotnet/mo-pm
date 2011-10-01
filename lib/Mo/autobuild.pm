package Mo::autobuild;my$M="Mo::";
$VERSION=0.25;
*{$M.'autobuild::e'}=sub{my($P,$e,$o)=@_;$_='builder';eval"no Mo::$_",&{$M.$_.::e}($P,$e,$o);$o->{builder}=sub{my($m,$n,%a)=@_;$a{builder}&&$a{builder}eq '1'||return$o->{builder};my$b="_build_$name";sub{$#_?$m->(@_):!exists$_[0]{$n}?$_[0]{$n}=$_[0]->$b:$m->(@_)}}};
