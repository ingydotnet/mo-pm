package Mo::exporter;my$M="Mo::";
$VERSION=0.35;
*{$M.'exporter::e'}=sub{my($P)=@_;if(defined@{$M.EXPORT}){*{$P.$_}=\&{$M.$_}for@{$M.EXPORT}}};
