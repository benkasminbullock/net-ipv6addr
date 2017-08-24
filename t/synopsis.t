use warnings;
use strict;
use utf8;
use FindBin '$Bin';
use Test::More;
my $builder = Test::More->builder;
binmode $builder->output,         ":utf8";
binmode $builder->failure_output, ":utf8";
binmode $builder->todo_output,    ":utf8";
binmode STDOUT, ":encoding(utf8)";
binmode STDERR, ":encoding(utf8)";
eval <<'EOF';
    use Net::IPv6Addr;
    my $addr = "dead:beef:cafe:babe::f0ad";
    Net::IPv6Addr::ipv6_parse($addr);
    my $x = Net::IPv6Addr->new($addr);
    print $x->to_string_preferred(), "\n";
EOF
ok (! $@);
if ($@) {
diag ($@);
}
done_testing ();
