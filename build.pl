#!/usr/bin/env perl
use warnings;
use strict;
use FindBin '$Bin';
use Getopt::Long;
chdir $Bin or die $!;
my $ok = GetOptions (
    verbose => \my $verbose,
    dist => \my $dist,
    all => \my $all,
    clean => \my $clean,
    pan => \my $pan,
);
if ($pan) {
    clean ();
    $dist = 1;
}

if ($clean) {
    clean ();
}
elsif ($all) {
    clean ();
    system ("git add .;git commit -a") == 0 or die "Git commit failed";
}
else {
    system ("perl Makefile.PL;make;make test") == 0 or die;
    if ($dist) {
	system ("make manifest;make dist") == 0 or die;
    }
}
if ($pan) {
    if (system ("prove xt/*.t")) {
	clean ();
	die "Author tests failed";
    }
}
exit;

sub clean
{
    if (-f "$Bin/Makefile") {
	system ("make clean") == 0 or warn "Make clean failed";
    }
    for my $badfile (qw/Makefile.old MANIFEST.bak/) {
	my $fullfile = "$Bin/$badfile";
	if (-f $fullfile) {
	    unlink $fullfile or warn "Could not rm $fullfile: $!";
	}
    }
    for my $glob (qw!*~ */*~ */*/*~ Net-IPv6Addr-[0-9]*!) {
	my @files = <$Bin/$glob>;
	if (@files) {
	    for my $file (@files) {
		unlink $file or warn "Could not rm $file: $!";
	    }
	}
    }
}

