# $Id: Makefile.PL,v 1.3 2002/09/30 04:57:56 andy Exp $
use strict;
use ExtUtils::MakeMaker;
use File::Find;

# Make sure I'm not editing any files
find( sub {die "$_ found" if /\.swp$/}, "." );

&WriteMakefile(
    NAME	    => 'Apache::Pod',
    DISTNAME	    => 'Apache-Pod',
    VERSION_FROM    => 'lib/Apache/Pod.pm',
    ABSTRACT_FROM   => 'lib/Apache/Pod.pm',
    PMLIBDIRS	    => [qw(lib/)],
    AUTHOR	    => 'Andy Lester <andy@petdance.com>',
    PREREQ_PM	    => {
			'Test::More'	=> 0,
			'Pod::Simple'	=> '0.93',
    },
    dist => {
	COMPRESS => 'gzip -9f', 
	SUFFIX => 'gz',
    },
);

