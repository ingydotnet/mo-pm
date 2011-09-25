use Test::More tests => 2;

use IO::All;

my $text = io('lib/Mo.pm')->all;

ok (($text =~ /\Apackage\s+Mo;\s*\$VERSION\b\s*=\s*.{4,6};\n/),
    'package and VERSION on first line'
);

ok (($text =~ /;\n\z/),
    'Mo ends with a semicolon and a newline character'
);
