#!/home/ben/software/install/bin/perl
use warnings;
use strict;
use Template;
use FindBin '$Bin';
use Perl::Build qw/get_info get_commit/;
use Perl::Build::Pod ':all';
use Deploy qw/do_system older/;
use Getopt::Long;
BEGIN: {
    use lib "$Bin/lib";
};
use Net::IPv6Addr ':all';
my $ok = GetOptions (
    'force' => \my $force,
    'verbose' => \my $verbose,
);
if (! $ok) {
    usage ();
    exit;
}
my %pbv = (
    base => $Bin,
    verbose => $verbose,
);
my $info = get_info (%pbv);
my $commit = get_commit (%pbv);
# Names of the input and output files containing the documentation.

my $pod = 'IPv6Addr.pod';
my $input = "$Bin/lib/Net/$pod.tmpl";
my $output = "$Bin/lib/Net/$pod";

# Template toolkit variable holder

my @exports = sort @Net::IPv6Addr::EXPORT_OK;

my %vars = (
    info => $info,
    commit => $commit,
    exports => \@exports,
);

my $tt = Template->new (
    ABSOLUTE => 1,
    INCLUDE_PATH => [
	$Bin,
	pbtmpl (),
	"$Bin/examples",
    ],
    ENCODING => 'UTF8',
    FILTERS => {
        xtidy => [
            \& xtidy,
            0,
        ],
    },
    STRICT => 1,
);

make_examples ("$Bin/examples");

my $ex = Net::IPv6Addr->new ('2001:db8::ff00:42:8329');

my %ex;
$ex{pref} = $ex->to_string_preferred ();
$ex{comp} = $ex->to_string_compressed ();
$ex{fool} = $ex->to_string_base85 ();
$ex{ipv64} = $ex->to_string_ipv4 ();
$ex{ipv64c} = $ex->to_string_ipv4_compressed ();
$vars{ex} = \%ex;
chmod 0644, $output;
$tt->process ($input, \%vars, $output, binmode => 'utf8')
    or die '' . $tt->error ();
chmod 0444, $output;

exit;

sub usage
{
print <<USAGEEOF;
--verbose
--force
USAGEEOF
}

