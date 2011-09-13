use Test::More tests => 2;
use IO::All;

BEGIN {
    my $module_path = 'xt/FooMo.pm';
    my $guts = io('lib/Mo.pm')->[1];
    chomp $guts;
    io($module_path)->print(<<"...");
package FooMo;
$guts;
1;
...
    push @INC, 'xt';

    END { unlink $module_path }
}

package TestInline;
use FooMo;

has this => builder => 'that';

sub that {
    $_[0]->thought;
}

sub thought {
    'Yep!';
}

package main;

my $t = TestInline->new;

is $t->this, 'Yep!', 'Yep';
ok $t->isa('FooMo::i'),
    'object isa FooMo::i';
