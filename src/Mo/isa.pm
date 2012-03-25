package Mo::isa;
$MoPKG = "Mo::";
$VERSION = 0.30;

$Z=CODE;
sub O(_){UNIVERSAL::can(@_,isa)}
sub S(&){pop}
sub Z{1}
sub R(){ref}
sub N(){!defined}
sub Y(){!N&&!R}

our%TC = (
	Any        , \&Z,  # *Z is more compact, but Mo::Golf can't cope
	Item       , \&Z,
	Bool       , S{N||0 eq$_||1 eq$_||''eq$_},
	Undef      , \&N,
	Defined    , S{!N},
	Value      , \&Y,
	Str        , \&Y,
	Num        , S{Y&&/^([+-]?\d+|[+-]?(?=\d|\.\d)\d*(\.\d*)?(e([+-]?\d+))?|(Inf(inity)?|NaN))$/i},
	Int        , S{/^\d+$/},
	Ref        , \&R,
	FileHandle , \&R,
	Object     , S{R && O},
	(map{$_.Name,S{Y && /^\S+$/}}qw/Class Role/),
	map
		{ my $J = /R/? $_ : uc$_; $_.Ref, S{R eq$J} }
		qw(Scalar Array Hash Code Glob Regexp));

sub check
{
	my $v = pop;
	
	return eval { $_[0]->($v); 1}
		if ref $_[0] eq$Z;
	
	@_ = split/\|/, shift;
	
	while (@_)
	{
		(my $t = shift) =~ s/^\s+|\s+$//g;
		
		if ($t =~ /^Maybe\[(.+)\]$/)
		{
			@_=(Undef,$1,@_);
			next
		}
		
		$t = $1 if $t =~ /^(.+)\[/;
		
		if (my $k = $TC{$t})
		{
			local $_ = $v;
			&$k&&return 1}
			
		elsif ($t =~ /::/)
		{
			O($v) && $v->isa($t) && return 1}

		else 
		{
			# I don't understand the constraint!
			return 1}
	}
	
	0}

sub av
{
	(my$t,$_)=@_;
	ref($t)eq$Z
		?$t->($_)
		:${die "not $t\n" if !check@_}
}

#my %cx;

*{$MoPKG.isa::e} = S
{
	my ($caller_pkg, $exports, $options) = @_;
	
	my $old_constructor = *{$caller_pkg.new}{$Z} || *{$MoPKG.Object::new}{$Z};
	*{$caller_pkg.new} = S
	{
		my %args = @_[1..$#_];
		
		av(($cx{$caller_pkg.$_}||next), $args{$_})for keys %args;
		
		goto$old_constructor
	};
	
	$options->{isa} = S
	{
		my ($method, $name, %args) = @_;
		my $V=$cx{$caller_pkg.$name} = $args{isa}
			or return $method;
		S {
			av$V, $_[1]if$#_;
			$method->(@_)
		}
	}
}
