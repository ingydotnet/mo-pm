use Test::More tests => 2;
use Cwd;
$ENV{PERL5LIB} = join(':', Cwd::abs_path('lib'), $ENV{PERL5LIB});
chdir 'xt/module-install' or die;
ok +(system("$^X Makefile.PL") == 0),
    'Mo works with Module::Install';
ok +(system("make purge") == 0),
    'make purge works';
