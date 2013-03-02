package Mo::nonlazy;my$M="Mo::";
$VERSION=0.33;
*{$M.'nonlazy::e'}=sub{${shift.N}=1};
