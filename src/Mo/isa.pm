package Mo::isa;
$MoPKG = "Mo::";
$VERSION = 0.30;

$Z='CODE';
sub O{UNIVERSAL::can(@_,'isa')}
sub Z{1}
sub R(){ref}
sub Y(){defined&&!ref}
sub L(){Y&&/^([+-]?\d+|[+-]?(?=\d|\.\d)\d*(\.\d*)?(e([+-]?\d+))?|(Inf(inity)?|NaN))$/i}

our%TC = (
	Any        , \&Z,  # *Z is more compact, but Mo::Golf can't cope
	Item       , \&Z,
	Bool       , sub{my$t=$_; !defined($t) or grep{"$_"eq$t}'',0,1},
	Undef      , sub{!defined},
	Defined    , sub{defined},
	Value      , \&Y,
	Str        , \&Y,
	Num        , \&L,
	Int        , sub{L && /^\d+$/},
	Ref        , \&R,
	FileHandle , \&R,
	Object     , sub{R && O($_)},
	(map{$_.Name,sub{Y && /^\S+$/}}qw/Class Role/),
	map
		{ my $J = /R/? $_ : uc$_; "${_}Ref", sub{R eq$J} }
		qw(Scalar Array Hash Code Glob Regexp));

sub check
{
	my $v = pop;
	
	if (ref $_[0] eq$Z)
	{
		return eval { $_[0]->($v); 1}
	}
	
	@_ = split/\|/, shift;
	
	while (@_)
	{
		(my $t = shift) =~ s/^\s+|\s+$//g;
		
		if ($t =~ /^Maybe\[(.+)\]$/)
		{
			@_=(Undef=>$1,@_);
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
	my$t=shift;
	ref($t)eq$Z
		?$t->(@_)
		:do{die "not $t\n" if !check$t, @_}
}

my %cx;

*{$MoPKG.isa::e} = sub
{
	my ($caller_pkg, $exports, $options) = @_;
	
	my $old_constructor = *{$caller_pkg.new}{$Z} || *{$MoPKG.Object::new}{$Z};
	*{$caller_pkg.new} = sub
	{
		my %args = @_[1..$#_];
		
		for (keys %args)
		{
			av$cx{$caller_pkg.$_}, $args{$_}if$cx{$caller_pkg.$_}
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
			av$V, $_[1]if$#_;
			$method->(@_)
		}
	}
}
