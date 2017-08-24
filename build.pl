#!/usr/bin/env perl
use warnings;
use strict;
use FindBin '$Bin';
chdir $Bin or die $!;
system ("perl Makefile.PL;make;make test") == 0 or die;
