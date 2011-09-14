use lib 'lib';
use inc::Module::Install;

all_from 'lib/Foo.pm';

include 'Foo';

WriteAll;
