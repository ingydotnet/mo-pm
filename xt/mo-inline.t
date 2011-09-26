use strict;
use warnings;

use Test::More;
use Test::More tests => 3;

use IO::All;

run();
exit;

sub run {
    my $mymo = "xt/MyMo.pm";

    "package MyMo;\n# use Mo qw'builder default';\n1;" > io $mymo;
    $ENV{PERL5LIB} ||= 'lib';
    `$^X bin/mo-inline xt/MyMo.pm`;
    require "xt/TestMyMo.pm";

    my $t = TestMyMo->new;

    is $t->this, 'Yep!', 'Inline builder works';
    is $t->thunk, 'DEfault', 'Inline default works';
    ok $t->isa('MyMo::Object'), 'object isa MyMo::Object';

    unlink $mymo if -e $mymo;

    return;
}
