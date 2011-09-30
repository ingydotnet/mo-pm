package Mo::moo;
my $MoPKG = 'Mo::';
$VERSION = '0.25';

use Mo();
*{$MoPKG.'moo::e'} = sub {
    (
        has => sub { Moo::has(@_, is => 'rw', lazy => 1) },
        extends => sub { Moo::extends(@_) },
        new => sub { Moo::new(@_) },
        with => sub { Moo::with(@_) },
    )
};
