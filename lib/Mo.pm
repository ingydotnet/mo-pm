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
    my $has = sub {
        my $self = shift;
        return $self->{$name} unless @_;
        return $self->{$name} = $_[0];
    };
    no strict 'refs';
    *{caller."::$name"} = $has;
}

sub extends {
    my $parent = shift;
    my $pkg = caller;
    no strict 'refs';
    @{"${pkg}::ISA"} = ($parent);
}

1;
