package Apache::Pod::Text;

=head1 NAME

Apache::Pod::Text - mod_perl handler to convert Pod to plain text

=head1 VERSION

Version 0.01

    $Header: /home/cvs/apache-pod/lib/Apache/Pod/Text.pm,v 1.2 2002/09/28 17:20:50 andy Exp $

=cut

use vars qw( $VERSION );

$VERSION = '0.01_01';

=head1 SYNOPSIS

A simple mod_perl handler to easily convert Pod to Text.

=head1 CONFIGURATION

See L<Apache::Pod::HTML> for configuration details.

=cut

use Apache::Pod;
use Pod::Simple::Text;

sub handler {
    my $r = shift;
    $r->content_type('text/plain');
    $r->send_http_header;

    my $str;
    my $file = Apache::Pod::getpod( $r );

    my $parser = Pod::Simple::Text->new;
    $parser->complain_stderr(1);
    $parser->output_string( \$str );
    $parser->parse_file( $file );

    print $str;
}

1;

=head1 AUTHOR

Andy Lester <andy@petdance.com>, adapted from Apache::Perldoc by
Rich Bowen <rbowen@ApacheAdmin.com>

=head1 LICENSE

This package is licensed under the same terms as Perl itself.

=cut
