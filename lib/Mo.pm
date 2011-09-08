use 5.010;
package Mo;
use strict;
use warnings;

our $VERSION = '0.11';

use base 'Exporter';

our @EXPORT = qw(extends has);

sub import {
    my $class = $_[0];
    strict->import;
    warnings->import;
    no strict 'refs';
    push @{caller.'::ISA'}, $class;
    goto &Exporter::import;
}

sub new {
    my $class = shift;
    bless {@_}, $class;
}

sub has {
    my $name = shift;
    no strict 'refs';
    *{caller."::$name"} = sub { @_-1 ? $_[0]->{$name} = $_[1] : $_[0]->{$name} };
}

sub extends {
    my $parent = shift;
    my $pkg = caller;
    no strict 'refs';
    @{"${pkg}::ISA"} = ($parent);
}

1;
