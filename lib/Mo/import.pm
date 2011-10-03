package Mo::import;my$M="Mo::";
$VERSION=0.25;
my$import=\&import;*{$M.import}=sub{if(@_==2 and not $_[1]){pop@_}elsif(@_==1){push@_,grep!/import/,@f}goto&$import};
