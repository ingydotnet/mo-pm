package Mo::has;my$K="Mo::";
$VERSION=0.25;
use Mo::default;use Mo::builder;*{$K.'has::e'}=sub{my$P=shift;&{$K.'builder::e'}($P,&{$K.'default::e'}($P,@_))};
