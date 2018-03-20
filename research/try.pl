#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use utf8;
use FindBin '$Bin';
use Net::IPv6Addr;
use Data::Validate::IP qw(is_ipv4 is_ipv6 is_private_ip);
my $ip = '2405:6581:d5c0:100:a14f:931b:494a:749d';
my $ni = Net::IPv6Addr->new ($ip);

print $ni->to_string_preferred, "\n";
print $ni->to_string_base85, "\n";
if (is_private_ip ($ip)) {
print "I sprivate\n";
}

