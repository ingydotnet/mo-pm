package Mo::default;my$M="Mo::";
$VERSION=0.31;
*{$M.'default::e'}=sub{my($P,$e,$o)=@_;$o->{default}=sub{my($m,$n,%a)=@_;exists$a{default}or return$m;die$n.' not a code ref'if ref($a{default})ne 'CODE';sub{$#_?$m->(@_):!exists$_[0]{$n}?$_[0]{$n}=$a{default}->(@_):$m->(@_)}}};
