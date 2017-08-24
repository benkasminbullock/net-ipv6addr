use ExtUtils::MakeMaker;
my $github = 'github.com/benkasminbullock/net-ipv6addr';
my $repo = "https://$github";
WriteMakefile(
    'NAME'	=> 'Net::IPv6Addr',
    'VERSION_FROM' => 'lib/Net/IPv6Addr.pm', # finds $VERSION
    'PREREQ_PM' => { 
	'Net::IPv4Addr' => 0, 
	'Math::Base85' => 0 
    },
    LICENSE => 'perl',
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
        x_contributors => [
	    'Jyrki Soini',
	    'Joacim Haggmark',
            'Ben Bullock <bkb@cpan.org>',
        ],
        bugtracker => {
	    web => "https://rt.cpan.org/Dist/Display.html?Name=Net-IPv6Addr",
	},
#	    homepage => 'http://',
        },
    },
);
