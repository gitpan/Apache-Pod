package Apache::Pod::HTML;

=head1 NAME

Apache::Pod::HTML - base class for converting Pod files to prettier forms

=head1 VERSION

Version 0.02

    $Header: /home/cvs/apache-pod/lib/Apache/Pod/HTML.pm,v 1.5 2002/09/30 04:42:05 andy Exp $

=cut

use strict;
eval 'use warnings' if $] >= 5.006;
use vars qw( $VERSION );

$VERSION = '0.02';

=head1 SYNOPSIS

A simple mod_perl handler to easily convert Pod to HTML or other forms.
You can also emulate F<perldoc>.

=head1 CONFIGURATION

=head2 Pod-to-HTML conversion

Add the following lines to your F<httpd.conf>.

    <Files *.pod>
	SetHandler perl-script
	PerlHandler Apache::Pod::HTML
    </Files>

All F<*.pod> files will magically be converted to HTML.

=head2 F<perldoc> emulation

The following configuration should go in your httpd.conf

    <Location /perldoc>
      SetHandler perl-script
      PerlHandler Apache::Pod::HTML
    </Location>

You can then get documentation for a module C<Foo::Bar> at the URL
C<http://your.server.com/perldoc/Foo::Bar>

Note that you can also get the standard Perl documentation with URLs
like C<http://your.server.com/perldoc/perlfunc> or just
C<http://your.server.com/perldoc> for the main Perl docs.

Finally, you can search for a particular Perl keyword with
C<http://your.server.com/perldoc/f/keyword> The 'f' is used by analogy
with the C<-f> flag to C<perldoc>.

=cut

use Apache::Pod;
use Pod::Simple::HTML;

sub handler {
    my $r = shift;
    $r->content_type('text/html');

    my $body;
    my $file = Apache::Pod::getpodfile( $r );
    warn "Got back [$file]";

    if ( $file ) {
	my $parser = Pod::Simple::HTML->new;
	$parser->output_string( \$body );
	$parser->parse_file( $file );
	# XXX Send the timestamp of the file in the header
    } else {
	$body = "<HTML><BODY>That module doesn't exist</BODY></HTML>";
    }

    $r->send_http_header;
    print $body;
}

1;

=head1 AUTHOR

Andy Lester <andy@petdance.com>, adapted from Apache::Perldoc by
Rich Bowen <rbowen@ApacheAdmin.com>

=head1 LICENSE

This package is licensed under the same terms as Perl itself.

=cut
