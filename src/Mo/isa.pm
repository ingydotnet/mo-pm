package Mo::isa;
$MoPKG = "Mo::";
$VERSION = 0.30;

use Scalar::Util qw/blessed looks_like_number/;

%Easy = (
	Any        => sub{1},
	Item       => sub{1},
	Bool       => sub{1},
	Undef      => sub{!defined$_[0]},
	Defined    => sub{defined$_[0]},
	Value      => sub{defined$_[0]&&!ref$_[0]},
	Str        => sub{defined$_[0]&&!ref$_[0]},
	Num        => sub{defined$_[0]&&!ref$_[0]&&looks_like_number($_[0])},
	Int        => sub{defined$_[0]&&!ref$_[0]&&looks_like_number($_[0])&&$_[0]!~/\./},
	ClassName  => sub{defined$_[0]&&!ref$_[0]&&$_[0]=~/^\S+$/},
	RoleName   => sub{defined$_[0]&&!ref$_[0]&&$_[0]=~/^\S+$/},
	Ref        => sub{defined$_[0]&&ref$_[0]},
	ScalarRef  => sub{defined$_[0]&&ref$_[0]eq'SCALAR'},
	ArrayRef   => sub{defined$_[0]&&ref$_[0]eq'ARRAY'},
	HashRef    => sub{defined$_[0]&&ref$_[0]eq'HASH'},
	CodeRef    => sub{defined$_[0]&&ref$_[0]eq'CODE'},
	RegexpRef  => sub{defined$_[0]&&ref$_[0]eq'Regexp'},
	GlobRef    => sub{defined$_[0]&&ref$_[0]eq'GLOB'},
	FileHandle => sub{defined$_[0]&&ref$_[0]},
	Object     => sub{defined$_[0]&&blessed$_[0]},
	);

sub check
{
	my $value = pop;
	my @cons = split /\|/, shift;
	
	while (@cons)
	{
		(my $con = shift @cons) =~ s{ (^\s+) | (\s+$) }{}xg;
		
		if ($con =~ /^Maybe\[(.+)\]$/)
		{
			unshift @cons, 'Undef', $1;
			next;
		}
		
		$con = $1 if $con =~ /^(.+)\[/;
		
		if (my $check = $Easy{$con})
		{
			return [$con] if $check->($value);
		}
		elsif ($con =~ /::/)
		{
			return [$con] if blessed($value) && $value->isa($con);
		}
		else 
		{
			# I don't understand the con!
			return [$con];
		}
	}
	
	return;
}

sub assert_value
{
	my ($con, $value) = @_;
	return if check($con, $value);
	die "value did not pass constraint $con\n";
}

*{$MoPKG.'isa::e'} = sub {
	my ($caller_pkg, $exports, $options) = @_;
	$options->{isa} = sub {
		my ($method, $name, %args) = @_;
		$args{isa} or return $method;
		return sub {
			assert_value($args{isa}, $_[1])if$#_;
			$method->(@_);
		};
	};
};
