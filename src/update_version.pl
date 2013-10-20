#!perl
use strict;
use warnings;
use 5.010;
use File::Basename;
use File::Find;
use File::Slurp;

my $basedir = dirname(__FILE__);

my ($version) = read_file("$basedir/Mo.pm") =~ /\$VERSION[\s=']+([\d.]+)/;
die 'Could not read version from Mo.pm' unless $version;
say "Setting version to: $version";

my @files = ( "$basedir/../lib/Mo/Inline.pm", "$basedir/../lib/Mo/Golf.pm" );
find(
  sub {
    push @files, $File::Find::name if $File::Find::name =~ /\.pm\z/;
  },
  $basedir
);

foreach my $f (@files) {
    my $code = read_file($f);
    if ($code !~ /\$VERSION=$version;/) {
        $code =~ s/\$VERSION[\s=']+[\d.]+;/\$VERSION=$version;/;
        write_file($f, $code);
    }
}
