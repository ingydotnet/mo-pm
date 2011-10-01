package Mo::autobuild;my$M="Mo::";
$VERSION=0.25;
no Mo::builder;*{$M.'autobuild::e'}=sub{&{$M.builder.::e}(@_)};
