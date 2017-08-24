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
);
if ($all) {
    if (-f "$Bin/Makefile") {
	system ("make clean") == 0 or warn "Make clean failed";
    }
    system ("git add .;git commit -a") == 0 or die "Git commit failed";
}
else {
    system ("perl Makefile.PL;make;make test") == 0 or die;
    if ($dist) {
	system ("make manifest;make dist") == 0 or die;
    }
}

