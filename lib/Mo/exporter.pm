package Mo::exporter;my$M="Mo::";
$VERSION=0.25;
*{$M.'exporter::e'}=sub{my($P,$e)=@_;@{$M.EXPORT};if(defined@{$M.EXPORT}){*{$P.$_}=\&{$M.$_}for@{$M.EXPORT}}};
