package Mo::isa;$M="Mo::";
$VERSION=0.30;
my$N=sub{$_[0]=~/^([+-]?\d+|([+-]?)(?=\d|\.\d)\d*(\.\d*)?(e([+-]?\d+))?|(Inf(inity)?|NaN))$/i };%TYPES=(Bool,sub{!$_[0]||$_[0]==1&&goto$N},Num,$N,Int,sub{$_[0]==int$_[0]&&goto$N},Str,sub{defined$_[0]},map{my$t=/R/ ?$_:uc$_;$_.Ref,sub{ref$_[0]eq $t}}<Array Code Hash Regexp>);*{$M."isa::e"}=sub{$_[2]{isa}=sub{my($m,$n,%a)=@_;my$I=$a{isa};$I?sub{ref$_[1]eq $I||$TYPES{$I}->($_[1])||die if $#_;goto$m}:$m}};
