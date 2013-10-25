package Mo::importer;my$M="Mo::";
$VERSION=0.37;
*{$M.'importer::e'}=sub{my($P,$e,$o,$f)=@_;(my$pkg=$P)=~s/::$//;&{$P.'importer'}($pkg,@$f)if defined&{$P.'importer'}};
