#!perl

# Ideally we would be using a Dist::Zilla plugin to generate the version numbers
# at release/build time, so it would always be correct but since we generate lib/
# files by filtering src/ code with Mo::Golf and both PkgVersion and OurPkgVersion
# add extra code to our minified .pm, let's at least validate we manually updated
# version numbers correctly.

use strict;
use warnings;

use Test::More;

use YAML qw(LoadFile);
use File::Basename;
my $release_version = LoadFile( dirname(__FILE__) . '/../META.yml' )->{version}
  or die 'Unable to determine release version?';

use File::Find;
use File::Temp qw{ tempdir };

my @modules;
find(
  sub {
    return if $File::Find::name !~ /\.pm\z/;
    my $found = $File::Find::name;
    $found =~ s{^lib/}{};
    $found =~ s{[/\\]}{::}g;
    $found =~ s/\.pm$//;
    # nothing to skip
    push @modules, $found;
  },
  'lib',
);

plan tests => scalar(@modules);

{
    # fake home for cpan-testers
     local $ENV{HOME} = tempdir( CLEANUP => 1 );

    is( qx{ $^X -Ilib -e "require $_; print $_->VERSION" }, $release_version, "$_ version ok" )
        for sort @modules;

}
