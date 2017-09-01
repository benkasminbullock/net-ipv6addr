use strict;
use Test::More;
use Net::IPv6Addr;

# Yeah, so I was listening to it when I wrote the test.
eval { Net::IPv6Addr::ipv6_parse("sunshine of your love"); };
ok($@);
like($@, qr/invalid IPv6 address/);

eval { Net::IPv6Addr::ipv6_parse("::/x"); };
ok($@);
like($@, qr/non-numeric prefix length/);

eval { Net::IPv6Addr::ipv6_parse("::/-19325"); };
ok($@);
like($@, qr/non-numeric prefix length/);

eval { Net::IPv6Addr::ipv6_parse("::/65389"); };
ok($@);
like($@, qr/invalid prefix length/);

is(scalar(Net::IPv6Addr::ipv6_parse("a:b:c:d:0:1:2:3")), "a:b:c:d:0:1:2:3");

my ($x, $y) = Net::IPv6Addr::ipv6_parse("a::/24");
is($x, "a::");
is($y, 24);

my ($x2, $y2) = Net::IPv6Addr::ipv6_parse('a::', '24');
is($x2, "a::");
is($y2, 24);
done_testing ();
