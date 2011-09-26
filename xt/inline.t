use Test::More tests => 3;
use IO::All;

my $module_path;
BEGIN {
    $module_path = 'xt/FooMo.pm';
    unlink $module_path;
    my $guts =
        io('lib/Mo.pm')->[-1] . "\n" .
        io('lib/Mo/builder.pm')->[-1] . "\n" .
        io('lib/Mo/default.pm')->[-1] . "\n" .
        '';
    chomp $guts;
    io($module_path)->print(<<"...");
package FooMo;
\@INC = (); # Make sure external mods are not loaded.
$guts;
1;
...
    push @INC, 'xt';
}

package TestInline;
use FooMo qw'default builder';

has this => builder => 'that';
has thunk => default => sub { 'DEfault' };

sub that {
    $_[0]->thought;
}

sub thought {
    'Yep!';
}

package main;

my $t = TestInline->new;

is $t->this, 'Yep!', 'Inline builder works';
is $t->thunk, 'DEfault', 'Inline default works';
ok $t->isa('FooMo::Object'), 'object isa FooMo::Object';

unlink $module_path;
