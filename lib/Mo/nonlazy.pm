package Mo::nonlazy;my$M="Mo::";
$VERSION=0.34;
*{$M.'nonlazy::e'}=sub{${shift.':N'}=1};
