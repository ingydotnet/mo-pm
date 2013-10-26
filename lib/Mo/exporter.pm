package Mo::exporter;my$M="Mo::";
$VERSION=0.38;
*{$M.'exporter::e'}=sub{my($P)=@_;if(@{$M.EXPORT}){*{$P.$_}=\&{$M.$_}for@{$M.EXPORT}}};
