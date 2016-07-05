package Mo::nonlazy;my$M="Mo::";
$VERSION='0.40';
*{$M.'nonlazy::e'}=sub{${shift().':N'}=1};
