use Test::More tests => 2;
use Cwd;
$ENV{PERL5LIB} = Cwd::abs_path('lib');
chdir 'xt/module-install' or die;
ok +(system("$^X Makefile.PL") == 0),
    'Mo works with Module::Install';
ok +(system("make purge") == 0),
    'make purge works';
