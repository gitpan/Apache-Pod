# $Id: 01.version.t,v 1.3 2003/09/10 03:19:07 andy Exp $

use Test::More tests=>5;
use strict;

BEGIN {
    use_ok( 'Apache::Pod' );
    use_ok( 'Apache::Pod::HTML' );
    use_ok( 'Apache::Pod::Text' );
}

is( $Apache::Pod::VERSION, $Apache::Pod::HTML::VERSION, 'A::P::HTML matches' );
is( $Apache::Pod::VERSION, $Apache::Pod::Text::VERSION, 'A::P::Text matches' );

