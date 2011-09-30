package Mo::coerce;$K="Mo::";
$VERSION=0.24;
*{$K.'coerce::e'}=sub{my($P,$p,$e)=@_;$p->{coerce}=sub{my($m,$n,%a)=@_;$a{coerce}or return$m;sub{$#_?$m->($_[0],$a{coerce}->($_[1])):$m->(@_)}};$e->{new}=sub{my($c,%a)=@_;my$s=bless{%a},$c;$s->$_($a{$_})for keys%a;$s}};
