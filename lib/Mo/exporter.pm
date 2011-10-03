package Mo::exporter;my$M="Mo::";
$VERSION=0.25;
*{$M.'exporter::e'}=sub{my($P,$e)=@_;if(defined@{$M.EXPORT}){*{$P.$_}=\&{$M.$_}for@{MoPKG.EXPORT}}};
