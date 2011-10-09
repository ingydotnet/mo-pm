use Test::More tests => 4;

{
    package Foo;
    use Mo 'Moose';

    has foo => ();
    has bar => (default => 'I like pie!');
}

my $f = Foo->new(foo => 42);

is $f->foo, 42, 'Normal';
is $f->{bar}, undef, 'before (lazy)';
is $f->bar, 'I like pie!', 'default';
is $f->{bar}, 'I like pie!', 'after';

