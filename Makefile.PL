# $Id: Makefile.PL,v 1.1.1.1 2002/09/28 15:43:36 andy Exp $
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
			'Pod::Simple'	=> '0.90',
    },
    dist => {
	COMPRESS => 'gzip -9f', 
	SUFFIX => 'gz',
    },
);

