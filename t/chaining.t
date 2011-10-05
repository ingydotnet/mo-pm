use Test::More;

plan tests => 22;

package Test::Chaining;
use Mo qw(chaining);

has 'first'  => (chaining => 1);
has 'second' => (chaining => 1);
has 'third'  => (chaining => 0);


package Test::ChainingWithDefault;
use Mo qw(chaining default);

has 'first'  => (chaining => 1, default => sub {11});
has 'second' => (chaining => 1, default => sub {12});
has 'third'  => (chaining => 0, default => sub {13});


package main;

### just chaining
my $f = Test::Chaining->new;

# not defined
is $f->first, undef;
is $f->third, undef;

# setter
isa_ok $f->first('foo'), 'Test::Chaining';
isa_ok $f->second('bar'), 'Test::Chaining';
is $f->third('baz'), 'baz';

# getter
is $f->first, 'foo';
is $f->second, 'bar';
is $f->third, 'baz';

# chain!
is $f->first(1)->second(2)->third(3), 3;
is $f->first, 1;
is $f->second, 2;



### chaining with default
$f = Test::ChainingWithDefault->new;

# not defined
is $f->first, 11;
is $f->third, 13;

# setter
isa_ok $f->first('21'), 'Test::ChainingWithDefault';
isa_ok $f->second('22'), 'Test::ChainingWithDefault';
is $f->third('23'), '23';

# getter
is $f->first, '21';
is $f->second, '22';
is $f->third, '23';

# chain!
is $f->first(31)->second(32)->third(33), 33;
is $f->first, 31;
is $f->second, 32;
