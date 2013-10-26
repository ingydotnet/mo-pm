package Mo::nonlazy;my$M="Mo::";
$VERSION=0.38;
*{$M.'nonlazy::e'}=sub{${shift.':N'}=1};
