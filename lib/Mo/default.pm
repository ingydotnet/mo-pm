package Mo::default;my$M="Mo::";
$VERSION=0.32;
*{$M.'default::e'}=sub{my($P,$e,$o)=@_;$o->{default}=sub{my($m,$n,%a)=@_;exists$a{default}or return$m;my($d,$r)=$a{default};my$g=($r=ref$d)eq 'HASH'?sub{+{%$d}}:'ARRAY'eq $r?sub{[@$d]}:'CODE'eq $r?$d:sub{$d};sub{$#_?$m->(@_):!exists$_[0]{$n}?$_[0]{$n}=$g->(@_):$m->(@_)}}};
