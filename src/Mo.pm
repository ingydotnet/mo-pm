package Mo;
$VERSION = 0.25;

no warnings;
my $MoPKG = __PACKAGE__."::";

*{$MoPKG.'Object::new'} = sub {
    my $class = shift;
    my $self = bless {@_}, $class;
    my @build_subs;

    do {
        @build_subs = ($class . '::BUILD', @build_subs)
    }
    while ($class) = @{ $class . '::ISA' };

    exists &$_ && &$_( $self ) for @build_subs;

    $self;
};

*{$MoPKG.'import'} = sub {
    import warnings;
    $^H |= 1538;
    my $caller_pkg = caller."::";
    my %exports = (
        extends => sub(*){
            eval "no $_[0]" . "()";
            @{ $caller_pkg . 'ISA' } = $_[0];
        },
        has => sub {
            my $name = shift;
            *{ $caller_pkg . $name } =
                sub {
                    $#_
                        ? $_[0]{$name} = $_[1]
                        : $_[0]{$name};
                };
        },
    );
    for (@_[1..$#_]) {
        eval "require Mo::$_;1";
        %exports = &{$MoPKG."${_}::e"}($caller_pkg => %exports);
    }
    *{ $caller_pkg . $_} = $exports{$_} for keys %exports;
    @{ $caller_pkg . 'ISA' } = $MoPKG.'Object';
};
