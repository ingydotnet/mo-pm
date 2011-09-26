package Mo::has;;package Mo;$K=__PACKAGE__."::";use Mo::default;use Mo::builder;
$VERSION=0.24;
*{$K.'has::e'}=sub{my$P=shift;&{$K.'builder::e'}($P,&{$K.'default::e'}($P,@_))};
