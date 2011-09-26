##
# name:      Mo::Inline
# abstract:  Inline Mo and Features into your package
# author:    Ingy döt Net <ingy@ingy.net>
# license:   perl
# copyright: 2011
# see:
# - Mo

package Mo::Inline;

use IO::All;

my $matcher = qr/((?m:^#\s*use Mo(\s.*)?;.*\n))(?:.{400,}\n)?/;

sub run {
    my $class = shift;
    my @files;
    if (not @_ or @_ == 1 and $_[0] =~ /^(?:-\?|-h|--help)$/) {
        warn usage();
        return 0;
    }
    for my $name (@_) {
        die "No file or directory called '$name'"
            unless -e $name;
        die "'$name' is not a Perl module"
            if -f $name and $name !~ /\.pm$/;
        if (-f $name) {
            push @files, $name;
        }
        elsif (-d $name) {
            push @_, grep /\.pm$/, map { "$_" } io($name)->all_files;
        }
    }

    die "No .pm files specified"
        unless @files;

    for my $file (@files) {
        my $text = io($file)->all;
        if ($text !~ $matcher) {
            warn "Ignoring $file - No Mo to Inline!\n";
            next;
        }
        $text =~ s/$matcher/"$1" . &inliner($2)/eg;
        io($file)->print($text);
        warn "Mo Inlined $file\n";
    }
}

sub inliner {
    my $mo = shift;
    require Mo;
    my @features = grep {$_ ne 'qw'} ($mo =~ /(\w+)/g);
    for (@features) {
        eval "require Mo::$_; 1" or die $@;
    }
    my $inline = '';
    $inline .= $_ for map {
        my $module = $_;
        $module .= '.pm';
        io($INC{$module})->[-1];
    } ('Mo', map { s!::!/!g; "Mo/$_" } @features);
    $inline .= "\n";
    return $inline;
}

sub usage {
    <<'...';
Usage: mo-linline <perl module files or directories>

...
}

1;

=head1 SYNOPSIS

In your module:

    package MyModule::Mo;
    # use Mo qw'builder default';
    1;

From the command line:

    > mo-inline lib/MyModule/Mo.pm

or:

    > mo-inline lib/

=head1 DESCRIPTION

Mo is so small that you can easily inline it, along with any feature modules.
Mo provides a script called C<mo-inline> that will do it for you.

All you need to do is comment out the line that uses Mo, and run C<mo-inline>
on the file. C<mo-inline> will find such comments and do the inlining for you.
It will also replace any old inlined Mo with the latest version.

What Mo could you possibly want?

=head1 EXAMPLES OF INLINING MO

For real world examples of Mo inlined using C<mo-inline>, see L<Pegex::Mo> and
L<TestML::Mo>.
