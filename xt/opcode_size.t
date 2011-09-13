use TestML -run;

sub count_ops {
    my $code = (shift)->value;
    $code = $code eq '_' ? '' : $code.',';
    0 + `perl -MO=Concise,$code-nobanner lib/Mo.pm 2>/dev/null | wc -l`;
}

__DATA__

%TestML 1.0

Plan = 3;

*code.count_ops == *count;


=== File scope opcode size
--- code: _
--- count: 35
--- count_before: 7

=== Import opcode size
--- code: Mo::import
--- count: 2
--- count_before: 56

=== New opcode size
--- code: Mo::_::new
--- count: 2
--- count_before: 88

