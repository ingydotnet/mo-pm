package Mo::Mouse;$MoPKG = "Mo::";
$VERSION=0.37;

*{$MoPKG.'Mouse::e'} = sub {
    my ($caller_pkg, $exports) = @_;
    $caller_pkg =~ s/::$//;
    %$exports = (M => 1);
    require Mouse;
#     require Mouse::Role;
    require Mouse::Util::MetaRole;
    Mouse->import({into => $caller_pkg});
    Mouse::Util::MetaRole::apply_metaroles(
        for => $caller_pkg,
        class_metaroles => { attribute => ['Attr::Trait'] },
    );
};

BEGIN {
    package Attr::Trait;
    use Mouse::Role;

    around _process_options => sub {
        my $orig = shift;
        my $class = shift;
        my ($name, $options) = @_;

        $options->{is} ||= 'rw';
        $options->{lazy} ||= 1
            if defined $options->{default} or
               defined $options->{builder};

        $class->$orig(@_);
    };
    $INC{'Attr/Trait.pm'} = 1;
}
