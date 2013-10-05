use Test::More tests => 8;
use IO::All;
# use XXX;use YAML;use YAML::Dumper;

use Mo::Inline;

my $module_path;
BEGIN {
    $module_path = 'xt/FooMo.pm';
    unlink $module_path;
    io($module_path)->print(<<"...");
package FooMo;
\@INC = (); # Make sure external mods are not loaded.
# use Mo qw'build default builder importer import';
1;
...
    push @INC, 'xt';
    Mo::Inline->new->inline($module_path);
}

package TestInline;
sub importer {
    Test::More::is "@_", 'TestInline build default builder importer', 'Mo::importer works';
}

use FooMo;
# use XXX;

has this => builder => 'that';
has thunk => default => sub { 'DEfault' };
has built => ();

sub BUILD {
    $_[0]->{built} = 'like a rock';
}

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
is $t->built, 'like a rock', 'BUILD works';


package TestInlineSelectiveImport;
use FooMo qw(default);

has this => builder => 'that';
has thunk => default => sub { 'DEfault' };
has built => ();

sub BUILD {
    $_[0]->{built} = 'like a rock';
}

sub that {
    $_[0]->thought;
}

sub thought {
    'Yep!';
}

package main;

my $t2 = TestInlineSelectiveImport->new;

is $t2->this, undef, 'no builder imported';
is $t2->thunk, 'DEfault', 'Inline default imported';
is $t2->built, undef, 'no build imported';

unlink $module_path;
