# $Id: Makefile.PL,v 1.4 2003/09/10 03:36:43 andy Exp $
use strict;
use ExtUtils::MakeMaker;
use File::Find;

# Make sure I'm not editing any files
find( sub {die "$_ found" if /\.swp$/}, "." );

&WriteMakefile(
    NAME            => 'Apache::Pod',
    DISTNAME        => 'Apache-Pod',
    VERSION_FROM    => 'lib/Apache/Pod.pm',
    ABSTRACT_FROM   => 'lib/Apache/Pod.pm',
    PMLIBDIRS       => [qw(lib/)],
    AUTHOR          => 'Andy Lester <andy@petdance.com>',
    PREREQ_PM       => {
                        'File::Find'        => 0,
                        'File::Spec'        => 0,
                        'Pod::Find'         => 0,
                        'Pod::Simple'       => '0.93',
                        'Pod::Simple::HTML' => 0,
                        'Pod::Simple::Text' => 0,
                        'Test::More'        => 0,
    },
    dist => {
        COMPRESS => 'gzip -9f', 
        SUFFIX => 'gz',
    },
);

