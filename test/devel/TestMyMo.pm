package TestMyMo;
use lib 'xt';
use MyMo;

has this => builder => 'that';
has thunk => default => sub { 'DEfault' };

sub that {
    $_[0]->thought;
}

sub thought {
    'Yep!';
}
