package Apache::Pod::HTML;

=head1 NAME

Apache::Pod::HTML - base class for converting Pod files to prettier forms

=head1 VERSION

Version 0.03

$Header: /home/cvs/apache-pod/lib/Apache/Pod/HTML.pm,v 1.12 2004/05/10 20:51:44 andy Exp $

=cut

use strict;
use vars qw( $VERSION );

$VERSION = '0.10';

use Apache::Pod;
use Apache::Constants;

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
        SetHandler  perl-script
        PerlHandler Apache::Pod::HTML
        PerlSetVar  STYLESHEET auto
    </Location>

You can then get documentation for a module C<Foo::Bar> at the URL
C<http://your.server.com/perldoc/Foo::Bar>

Note that you can also get the standard Perl documentation with URLs
like C<http://your.server.com/perldoc/perlfunc> or just
C<http://your.server.com/perldoc> for the main Perl docs.

Finally, you can search for a particular Perl keyword with
C<http://your.server.com/perldoc/f/keyword> The 'f' is used by analogy
with the C<-f> flag to C<perldoc>.

Specifying 'auto' for the stylesheet will cause the built-in CSS stylesheet
to be used.  If you prefer, you can replace the word 'auto' with the URL of
your own custom stylesheet file.

=cut

sub handler {
    my $r = shift;

    if ( $r->path_info eq '/auto.css' ) {
        $r->content_type( 'text/css' );
        $r->send_http_header;
        print _css();
        return OK;
    }

    my $body;
    my $file = Apache::Pod::getpodfile( $r );

    if ( $file ) {
        my $parser = My::Pod::Simple::HTML->new;
        $parser->no_errata_section(1);
        $parser->complain_stderr(1);
        $parser->output_string( \$body );
        $parser->parse_file( $file );
        # TODO: Send the timestamp of the file in the header

        my $stylesheet = $r->dir_config('STYLESHEET') || '';
        $stylesheet = $r->location . '/auto.css' if $stylesheet =~ /^auto/i;
        if ( $stylesheet ) {
            # Stick in a link to our stylesheet
            $stylesheet = qq(<LINK REL="stylesheet" HREF="$stylesheet" TYPE="text/css">);
            $body =~ s{(?=</head)}{$stylesheet\n}i;
        }
    } else {
        $body = "<HTML><HEAD><TITLE>Not found</TITLE></HEAD><BODY>That module doesn't exist</BODY></HTML>";
    }

    $r->content_type('text/html');
    $r->send_http_header;
    print $body;

    return OK;
}

sub _css {
    return <<'EOF';
BODY {
    background: white;
    color: black;
    font-family: times,serif;
    margin: 0;
    padding: 1ex;
}

TABLE {
    border-collapse: collapse;
    border-spacing: 0;
    border-width: 0;
    color: inherit;
}

A:link, A:visited {
    background: transparent;
    color: #006699;
}

PRE {
    background: #eeeeee;
    border: 1px solid #888888;
    color: black;
    padding-top: 1em;
    padding-bottom: 1em;
    white-space: pre;
}

H1 {
    background: transparent;
    color: #006699;
    font-size: x-large;
    font-family: tahoma,sans-serif;
}

H2 {
    background: transparent;
    color: #006699;
    font-size: large;
    font-family: tahoma,sans-serif;
}

.block {
    background: transparent;
}

TD .block {
    color: #006699;
    background: #dddddd;
    padding: 0.2em;
    font-size: large;
}

HR {
    display: none;
}
EOF
}

package My::Pod::Simple::HTML;

use Pod::Simple::HTML;

our @ISA = qw( Pod::Simple::HTML );

*VERSION = *Pod::Simple::HTML::VERSION;

sub resolve_pod_page_link {
    my $self = shift;
    my $to = shift;
    my $section = shift;

    my $link = $to;

    return $link;
}

=head1 AUTHOR

Andy Lester C<< <andy@petdance.com> >>, adapted from Apache::Perldoc by
Rich Bowen C<< <rbowen@ApacheAdmin.com> >>

=head1 LICENSE

This package is licensed under the same terms as Perl itself.

=cut

1;
