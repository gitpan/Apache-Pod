# $Id: 01.version.t,v 1.2 2002/09/28 17:20:30 andy Exp $

use Test::More tests=>5;
use strict;
eval 'use warnings' if $] >= 5.006;

BEGIN {
    use_ok( 'Apache::Pod' );
    use_ok( 'Apache::Pod::HTML' );
    use_ok( 'Apache::Pod::Text' );
}

is( $Apache::Pod::VERSION, $Apache::Pod::HTML::VERSION, 'Versions match' );
is( $Apache::Pod::VERSION, $Apache::Pod::Text::VERSION, 'Versions match' );

