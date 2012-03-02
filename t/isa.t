use Test::More ;

BEGIN {
	eval 'use Test::Exception; 1'
		or plan skip_all => 1;
}

plan tests => 200;

{
	package Foo::isa;
	use Mo qw(isa);
	has any         => (isa => 'Any');
	has item        => (isa => 'Item');
	has bool        => (isa => 'Bool');
	has undef       => (isa => 'Undef');
	has defined     => (isa => 'Defined');
	has value       => (isa => 'Value');
	has string      => (isa => 'Str');
	has number      => (isa => 'Num');
	has integer     => (isa => 'Int');
	has maybe_int   => (isa => 'Maybe[Int]');
	has misc        => (isa => 'Int|HashRef');
	has classname   => (isa => 'ClassName');
	has rolename    => (isa => 'RoleName');
	has ref         => (isa => 'Ref');
	has scalarref   => (isa => 'ScalarRef');
	has arrayref    => (isa => 'ArrayRef');
	has hashref     => (isa => 'HashRef');
	has coderef     => (isa => 'CodeRef');
	has regexpref   => (isa => 'RegexpRef');
	has globref     => (isa => 'GlobRef');
	has filehandle  => (isa => 'FileHandle');
	has object      => (isa => 'Object');
	has foo         => (isa => 'Foo::isa');
}

my $f = Foo::isa::->new;

my @tests = (
	[ any        => ['abc', 1, 1.5, [], {}],   [] ],
	[ item       => ['abc', 1, 1.5, [], {}],   [] ],
	[ bool       => [1, 0],                    [] ],
	[ undef      => [undef],                   [0, 1, '', {}] ],
	[ defined    => [0, 1, '', {}, $f],        [undef] ],
	[ value      => [0, 1, ''],                [undef, [], {}, $f] ],
	[ string     => ['1', 'abc', ''],          [undef, [], {}, $f] ],
	[ number     => [1, 1.5, '100'],           ['', 'abc', $f] ],
	[ integer    => [1, '100'],                ['', 1.5, 'abc', $f] ],
	[ maybe_int  => [1, '100', undef],         ['', 1.5, 'abc', $f] ],
	[ misc       => [3, {}],                   [1.5] ],
	[ classname  => ['DateTime', 'Foo::isa'],  ['Foo isa'] ],
	[ rolename   => ['DateTime', 'Foo::isa'],  ['Foo isa'] ],
	[ ref        => [[], {}, $f],              [0, 1, '', undef] ],
	[ scalarref  => [\(my $x='abc')],          [0, 1, {}] ],
	[ arrayref   => [[]],                      [0, 1, {}] ],
	[ hashref    => [{}],                      [0, 1, []] ],
	[ coderef    => [sub{}],                   [0, 1, []] ],
	[ regexpref  => [qr{abc}],                 [0, 1, []] ],
	# globref
	# filehandle
	[ object     => [$f],                      [0, 1, {}] ],
	[ foo        => [$f],                      [0, 1, {}] ],
	);

foreach my $set (@tests)
{
	my ($attribute, $should_allow, $should_deny) = @$set;
	
	foreach my $value (@$should_allow)
	{
		my $sv = defined $value ? "`$value`" : 'undef';
		
		lives_and {
			$f->$attribute($value);
			is $f->$attribute(), $value;
		} "Attribute $attribute accepts value $sv";
		
		lives_and {
			my $f2 = Foo::isa::->new($attribute => $value);
			is $f->$attribute(), $value;
		} "Attribute $attribute accepts value $sv in constructor";
	}

	foreach my $value (@$should_deny)
	{
		my $sv = defined $value ? "`$value`" : 'undef';
		
		dies_ok {
			$f->$attribute($value);
		} "Attribute $attribute denies value $sv";
		
		dies_ok {
			my $f2 = Foo::isa::->new($attribute => $value);
		} "Attribute $attribute denies value $sv in constructor";
	}
}
