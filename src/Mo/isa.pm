package Mo::isa;
$MoPKG = "Mo::";
$VERSION = 0.30;

# Regexp from &Scalar::Util::looks_like_number:
my $N = sub {
        $_[0] =~ /^([+-]?\d+|([+-]?)(?=\d|\.\d)\d*(\.\d*)?(e([+-]?\d+))?|(Inf(inity)?|NaN))$/i };
%TYPES = (
    Bool, sub { !$_[0] || $_[0] == 1 && &$N },
    Num, $N,
    Int, sub { $_[0] == int $_[0] && &$N },
    Str, sub { defined $_[0] },

    # Ref types:
    map {
        my $type = /R/ ? $_ : uc $_;
        $_.Ref, sub { ref $_[0] eq $type }  } qw(Array Code Hash Regexp) );

*{$MoPKG."isa::e"} = sub {
    $_[2]{isa} = sub {
        my ($method, $name, %args) = @_;
        my $I = $args{isa};
        $I
            ? sub {
                ref $_[1] eq $I || $TYPES{$I}->($_[1]) || die if $#_;
                &$method; }
            : $method } };
