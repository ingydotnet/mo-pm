package Mo::isa;
$MoPKG = "Mo::";
$VERSION = 0.30;

sub O{UNIVERSAL::can(@_,'isa')}
sub Z{1}
sub R(){ref}
sub Y(){defined&&!ref}
sub L(){Y&&/^([+-]?\d+|([+-]?)(?=\d|\.\d)\d*(\.\d*)?(e([+-]?\d+))?|(Inf(inity)?|NaN))$/i}

our%TC = (
	Any        , \&Z,
	Item       , \&Z,
	Bool       , \&Z,
	Undef      , sub{!defined},
	Defined    , sub{defined},
	Value      , \&Y,
	Str        , \&Y,
	Num        , \&L,
	Int        , sub{L && int($_)==$_},
	Ref        , \&R,
	FileHandle , \&R,
	Object     , sub{R && O($_)},
	(map{$_.Name,sub{Y && /^\S+$/}}qw/Class Role/),
	map
		{ my $J = /R/? $_ : uc$_; "${_}Ref", sub{R eq$J} }
		qw/Scalar Array Hash Code Glob Regexp/,
	);

sub check
{
	my $v = pop;
	
	if (ref $_[0] eq'CODE')
	{
		return eval { $_[0]->($v); 1}
	}
	
	@_ = split/\|/, shift;
	
	while (@_)
	{
		(my $t = shift) =~ s/(^\s+)|(\s+$)//g;
		
		if ($t =~ /^Maybe\[(.+)\]$/)
		{
			unshift @_, 'Undef', $1;
			next
		}
		
		$t = $1 if $t =~ /^(.+)\[/;
		
		if (my $k = $TC{$t})
		{
			local $_ = $v;
			return 1 if $k->()
		}
		elsif ($t =~ /::/)
		{
			return 1 if O($v) && $v->isa($t)
		}
		else 
		{
			# I don't understand the constraint!
			return 1}
	}
	
	0}

sub av
{
	my$t=shift;
	ref($t)eq'CODE'
		?$t->(@_)
		:do{die "not $t\n" if !check($t, @_)}
}

my %cx;

*{$MoPKG.isa::e} = sub
{
	my ($caller_pkg, $exports, $options) = @_;
	
	my $old_constructor = *{$caller_pkg.new}{CODE} || *{$MoPKG.Object::new}{CODE};
	*{$caller_pkg.new} = sub
	{
		my %args = @_[1..$#_];
		
		for (keys %args)
		{
			av($cx{$caller_pkg.$_}, $args{$_}) if $cx{$caller_pkg.$_}
		}
		
		goto$old_constructor
	};
	
	$options->{isa} = sub
	{
		my ($method, $name, %args) = @_;
		my $V=$cx{$caller_pkg.$name} = $args{isa}
			or return $method;
		sub
		{
			av($V, $_[1])if$#_;
			$method->(@_)
		}
	}
}
