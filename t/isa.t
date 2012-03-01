use strict;
use warnings FATAL => "all";
use Test::More tests => 45;
use Test::Exception;

package Foo::isa;
use Mo qw(isa);

my @types = qw(Bool Num Int Str ArrayRef CodeRef HashRef RegexpRef);
my @refs = ([], sub { }, {}, qr( ));
has( "my$_" => ( isa => $_ ) ) for @types;
has( myFoo => ( isa => "Foo::isa" ) );

package main;
use Data::Dump;

my $foo = Foo::isa->new( myStr => "abcdefg" );

# Bool:
lives_and { ok !$foo->myBool(undef) } "Bool attr set to undef";
lives_and { is $foo->myBool(1), 1 }   "Bool attr set to 1";
is $foo->myBool, 1, "new value of \$foo->myBool as expected";
lives_and { is $foo->myBool(1e0), 1 } "Bool attr set to 1e0";
dies_ok { $foo->myBool("1f0") }       "Bool attr set to 1f0 dies";
lives_and { is $foo->myBool(""), "" } "Bool attr set to empty string";
is $foo->myBool, "", "new value of \$foo->myBool as expected";
lives_and { is $foo->myBool(0), 0 }   "Bool attr set to 0";
lives_and { is $foo->myBool(0.0), 0 } "Bool attr set to 0.0";
lives_and { is $foo->myBool(0e0), 0 } "Bool attr set to 0e0";
dies_ok { $foo->myBool("0.0") }       "Bool attr set to stringy 0.0 dies";

# Num:
lives_and { is $foo->myNum(5.5), 5.5 } "Num attr set to decimal";
is $foo->myNum, 5.5, "new value of \$foo->myNum as expected";
lives_and { is $foo->myNum(5), 5 } "Num attr set to integer";
lives_and { is $foo->myNum(5e0), 5 } "Num attr set to 5e0";
dies_ok { $foo->myBool("5f0") }       "Bool attr set to 5f0 dies";
lives_and { is $foo->myNum("5.5"), 5.5 } "Num attr set to stringy decimal";

# Int:
lives_and { is $foo->myInt(0), 0 }   "Int attr set to 0";
lives_and { is $foo->myInt(1), 1 }   "Int attr set to 1";
lives_and { is $foo->myInt(1e0), 1 } "Int attr set to 1e0";
is $foo->myInt, 1, "new value of \$foo->myInt as expected";
dies_ok { $foo->myInt("") } "Int attr set to empty string dies";
dies_ok { $foo->myInt(5.5) } "Int attr set to decimal dies";

# Str:
is $foo->myStr, "abcdefg", "Str passed to constructor accepted";
lives_and { is $foo->myStr("hijklmn"), "hijklmn" } "Str attr set to a string";
is $foo->myStr, "hijklmn", "new value of \$foo->myStr as expected";
lives_and { is $foo->myStr(5.5), 5.5 } "Str attr set to a decimal value";

# Class instance:
lives_and { is $foo->myFoo($foo), $foo } "Class instance attr set to self";
isa_ok $foo->myFoo, "Foo::isa", "new value of \$foo->myFoo as expected";
dies_ok { $foo->myFoo({}) } "Class instance attr set to hash dies";

# Refs:
for my $i (4..7) {
    my $method = "my" . $types[$i];
    lives_ok(
        sub { $foo->$method($refs[$i - 4]) },
        "$types[$i] attr set to correct reference type" ); }
for my $i (4..7) {
    my $method = "my" . $types[$i];
    dies_ok(
        sub { $foo->$method($refs[(3 + $i) % 4]) },
        "$types[$i] attr set to incorrect reference type dies" ); }

# All but Bool vs undef:
for my $type (@types[1..$#types]) {
    my $method = "my$type";
    dies_ok { $foo->$method(undef) } "$type attr set to undef dies" }
