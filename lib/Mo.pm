##
# name:      Mo
# abstract:  Micro Objects
# author:    Ingy döt Net <ingy@cpan.org>
# license:   perl
# copyright: 2011

use 5.010;
package Mo;
use strict;
use warnings;

our $VERSION = '0.10';

use base 'Exporter';

our @EXPORT = qw(extends has);

sub import {
    my $class = $_[0];
    my $pkg = caller;
    strict->import;
    warnings->import;
    no strict 'refs';
    push @{"${pkg}::ISA"}, $class;
    goto &Exporter::import;
}

sub new {
    my $class = shift;
    my $self = bless {@_}, $class;
}

sub has {
    my $name = shift;
    my $pkg = caller;
    my $has = sub {
        my $self = shift;
        return $self->{$name} unless @_;
        return $self->{$name} = $_[0];
    };
    no strict 'refs';
    *{"${pkg}::$name"} = $has;
}

sub extends {
    my $parent = shift;
    my $pkg = caller;
    no strict 'refs';
    @{"${pkg}::ISA"} = ($parent);
}

1;

=head1 SYNOPSIS

    package Reaper;
    use Mo 'Cow Bell';
    extends 'SNL';

    has noise => (is =>'ro');

=head1 DESCRIPTION

Moose led to Mouse led to Moo led to Mo. M, anyone?
