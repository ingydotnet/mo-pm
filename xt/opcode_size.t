use Test::More;

use FindBin qw($Bin);
plan tests => 3;

is count(''), 7, 'file scope opcode size';
is count('Mo::import,'), 56, 'import opcode size';
is count('Mo::_::new,'), 88, 'new opcode size';

sub count {
    `perl -MO=Concise,$_[0]-nobanner $Bin/../lib/Mo.pm 2>/dev/null | wc -l` + 0;
}
