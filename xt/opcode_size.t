use Test::More;

use FindBin qw($Bin);
plan tests => 1;

my $opcode_1 = `perl -MO=Concise,-nobanner $Bin/../lib/Mo.pm 2>/dev/null | wc -l`;
my $opcode_2 = `perl -MO=Concise,Mo::import,-nobanner $Bin/../lib/Mo.pm 2>/dev/null | wc -l`;
my $opcode_3 = `perl -MO=Concise,Mo::_::new,-nobanner $Bin/../lib/Mo.pm 2>/dev/null | wc -l`;

is $opcode_1+$opcode_2+$opcode_3, 151, 'opcode size';
