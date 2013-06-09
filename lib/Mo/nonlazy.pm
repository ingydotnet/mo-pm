package Mo::nonlazy;my$M="Mo::";
$VERSION=0.36;
*{$M.'nonlazy::e'}=sub{${shift.':N'}=1};
