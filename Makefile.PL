# $Id: Makefile.PL,v 1.5 2004/05/10 20:51:44 andy Exp $
use strict;
use ExtUtils::MakeMaker;

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
                        'Pod::Simple'       => '2.06',
                        'Pod::Simple::HTML' => 0,
                        'Pod::Simple::Text' => 0,
                        'Test::More'        => 0,
    },
    dist => {
        COMPRESS => 'gzip -9f', 
        SUFFIX => 'gz',
    },
);

