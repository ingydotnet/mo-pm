#!/usr/bin/perl

run( @ARGV );

sub run {
    my ( $script, $engine ) = @ARGV;

    $script ||= '';
    my @engines = $engine ? ( $engine ) : qw( Mo Moo Mouse Moose );

    prove_engine( $script, $_ ) for @engines;

    return;
}

sub prove_engine {
    my ( $script, $engine ) = @_;

    eval "require $engine;1;" or return print "$engine not found, skipping";

    print "\nproving $engine\n\n";
    system( "prove $script :: $engine" );

    return;
}
