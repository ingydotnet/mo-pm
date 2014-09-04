package Mo::nonlazy;my$M="Mo::";
$VERSION=0.39;
*{$M.'nonlazy::e'}=sub{${shift().':N'}=1};
