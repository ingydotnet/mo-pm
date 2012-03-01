package Mo::isa;
$MoPKG = "Mo::";
$VERSION = 0.30;

# Regexp from &Scalar::Util::looks_like_number:
my $N = sub {
        $_[0] =~ /^([+-]?\d+|([+-]?)(?=\d|\.\d)\d*(\.\d*)?(e([+-]?\d+))?|(Inf(inity)?|NaN))$/i };
%TYPES = (
    Bool, sub { !$_[0] || $_[0] == 1 && goto $N },
    Num, $N,
    Int, sub { $_[0] == int $_[0] && goto $N },
    Str, sub { defined $_[0] },

    # Ref types:
    ( map {
        my $type = $_;
        ref()
            ? sub { ref $_[0] eq ref $type }
            : $_.Ref } Array, [], Code, $N, Hash, {}, Regexp, qr( ) ) );
*{$MoPKG."isa::e"} = sub {
    $_[2]{isa} = sub {
        my ($method, $name, %args) = @_;
        my $I = $args{isa};
        $I
            ? sub {
                ref $_[1] eq $I || $TYPES{$I}->($_[1]) || die if $#_;
                goto $method; }
            : $method } };
