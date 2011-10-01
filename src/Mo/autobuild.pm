package Mo::autobuild;
my $MoPKG = "Mo::";
$VERSION = 0.25;

*{$MoPKG.'autobuild::e'} = sub {
    my ($caller_pkg, $exports, $options) = @_;
    
    eval "no Mo::$_",
        &{$MoPKG.$_.::e}(
            $caller_pkg,
            $exports,
            $options
        ) for 'builder';
    
    my $old_builder = $options->{builder};
    $options->{builder} = sub {
        my ($method, $name, %args) = @_;
        
        $args{builder} && $args{builder} eq '1'
            || return $old_builder->(@_);
        
        my $builder = "_build_$name";
        sub {
            $#_
              ? $method->(@_)
                : ! exists $_[0]{$name}
                    ? $_[0]{$name} = $_[0]->$builder
                    : $method->(@_)
        };
    };
};
