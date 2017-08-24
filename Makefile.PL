use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
my $github = 'github.com/benkasminbullock/net-ipv6addr';
my $repo = "https://$github";
WriteMakefile(
    'NAME'	=> 'Net::IPv6Addr',
    'VERSION_FROM' => 'lib/Net/IPv6Addr.pm', # finds $VERSION
    'PREREQ_PM' => { 
	'Net::IPv4Addr' => 0, 
	'Math::Base85' => 0 
    },
    META_MERGE => {
	'meta-spec' => {
	    version => 2,
	},
        resources => {
            repository => {
		type => 'git',
		url => "git://$github.git",
		web => $repo,
	    },
#            bugtracker => {
#		web => "$repo/issues",
#	    },
#	    homepage => 'http://',
        },
    },
);
