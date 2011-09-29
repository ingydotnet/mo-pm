package Mo::has;
$VERSION=0.24;
package Mo;$K=__PACKAGE__."::";use Mo::default;use Mo::builder;*{$K.'has::e'}=sub{my$P=shift;&{$K.'builder::e'}($P,&{$K.'default::e'}($P,@_))};
