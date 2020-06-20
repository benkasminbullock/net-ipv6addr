#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use utf8;
use FindBin '$Bin';
use File::Slurper 'read_text';
use Test::More;
my $pm = read_text ("$Bin/../lib/Net/IPv6Addr.pm");
my @subs;
while ($pm =~ /#\s*Public\s+sub\s+(\S+)/gi) {
    push @subs, $1;
}
my %subs;
for (@subs) {
    $subs{$_} = 1;
}
my $pod = read_text ("$Bin/../lib/Net/IPv6Addr.pod");
ok ($pod =~ /=head1 METHODS AND FUNCTIONS(.*?)=head1/gsm, 
    "Has methods and functions");
my $func = $1;
ok (length ($func) > 100, "found functions");
my @docs;
while ($func =~ /=head2\s+(\S+)/g) {
    push @docs, $1;
}
my %docs;
for (@docs) {
    ok ($subs{$_}, "Public function $_ is documented");
    $docs{$_} = 1;
}
for (@subs) {
    ok ($docs{$_}, "Documented function $_ exists");
}
my @sdocs = sort @docs;
for my $i (0..$#sdocs) {
    ok ($sdocs[$i] eq $docs[$i], "Sorted order OK $i $sdocs[$i] $docs[$i]");
}
done_testing ();
