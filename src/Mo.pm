# The following two lines are left alone in the compressed source.
package Mo;
$VERSION='0.40';

# 'no' is a shorter 'use', but we really don't want warnings.
no warnings;
# We need the package name to be relocatable for inlining. Adding the :: makes
# everything shorter thereafter. We do that a lot for
# golfing reasons. Scary.
my $MoPKG = __PACKAGE__.'::';

# This is our minimal constructor. Can we make it faster? We should have tests
# for that.
*{$MoPKG.Object::new} = sub {
    my $class            = shift;
    my $self             = bless {@_}, $class;
    my %nonlazy_defaults = %{ $class . '::' . EAGERINIT };
    map { $self->{$_} = $nonlazy_defaults{$_}->() if !exists $self->{$_} }
      keys %nonlazy_defaults;
    $self
};

*{$MoPKG.import} = sub {
    # Set warnings for the caller.
    import warnings;
    # This is a golf for: use strict(); strict->import;
    $^H |= 1538;
    my ($caller_pkg, %exports, %options) = caller.'::';
    shift;
    # Load each feature and call its &e.
    eval "no Mo::$_",
        &{$MoPKG.$_.::e}(
            $caller_pkg,
            \%exports,
            \%options,
            \@_
        ) for @_;
    return if $exports{M};
    %exports = (
        extends, sub {
            eval "no $_[0]()";
            @{ $caller_pkg . ISA } = $_[0];
        },
        has, sub {
            my $name = shift;
            my $method =
                sub {
                    $#_
                        ? $_[0]{$name} = $_[1]
                        : $_[0]{$name};
                };
            @_ = ( default, @_ ) if !($#_%2);
            $method = $options{$_}->($method, $name, @_)
                for sort keys %options;
            *{ $caller_pkg . $name } = $method;
        },
        %exports,
    );
    *{ $caller_pkg . $_} = $exports{$_}
        for keys %exports;
    @{ $caller_pkg . ISA } = $MoPKG.Object;
};
