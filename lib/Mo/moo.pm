package Mo::moo;my$K='Mo::';
$VERSION='0.25';
use Mo();*{$K.'moo::e'}=sub{(has=>sub{Moo::has(@_,is=>'rw',lazy=>1)},extends=>sub{Moo::extends(@_)},new=>sub{Moo::new(@_)},with=>sub{Moo::with(@_)},)};
