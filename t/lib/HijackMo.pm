package HijackMo;

sub import {
    my ( undef, $engine ) = @_;

    $engine ||= $ARGV[0];

    return if !$engine or $engine eq 'Mo';

    eval "require $engine;";
    *Mo::import = sub {
        shift;
        @_ = ( $engine, @_ );    # breaks in older perls, ensure the engine package remains itself
        goto $engine->can( "import" );
    };
    $INC{'Mo.pm'} = 1;

    return;
}

1;
