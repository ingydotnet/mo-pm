package xt::TestClass;
use lib 'lib';
use Mo;

has 'bare';

has default => default => sub {'string'};

package main;

our $t1 = xt::TestClass->new;

1;
