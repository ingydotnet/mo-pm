package Mo::default;my$M="Mo::";
$VERSION=0.32;
*{$M.'default::e'}=sub{my($P,$e,$o)=@_;$o->{default}=sub{my($m,$n,%a)=@_;exists$a{default}or return$m;my$d=$a{default};my$gen=ref($d)eq 'HASH'?sub{+{%$d}}:ref($d)eq 'ARRAY'?sub{[@$d]}:ref($d)eq 'CODE'?$d:sub{$d};sub{$#_?$m->(@_):!exists$_[0]{$n}?$_[0]{$n}=$gen->(@_):$m->(@_)}}};
