package Apache::Pod;

=head1 NAME

Apache::Pod - base class for converting Pod files to prettier forms

=head1 VERSION

Version 0.01

    $Header: /home/cvs/apache-pod/lib/Apache/Pod.pm,v 1.4 2002/09/28 17:20:50 andy Exp $

=cut

use vars qw( $VERSION );

$VERSION = '0.01_01';

=head1 SYNOPSIS

The Apache::Pod::* are mod_perl handlers to easily convert Pod to HTML
or other forms.  You can also emulate F<perldoc>.

=head1 CONFIGURATION

All configuration is done in one of the subclasses.

=head1 TODO

I could envision a day when the user can specify which output format
he'd like from the URL, such as

    http://your.server/perldoc/f/printf?rtf

=head1 FUNCTIONS

No functions are exported.  I don't want to dink around with Exporter in mod_perl if I don't need to.

=head2 C<< getpod( I<$r> ) >>

Returns the filename requested off of the C<$r> request object.

=cut

sub getpod {
    my $r = shift;

    my $pod;

    if ($r->filename =~ m/\.pod$/i) {
        $pod = $r->filename;
    } else {
        $pod = $r->path_info;
        $pod =~ s|/||;
        $pod =~ s|/|::|g;
        $pod =~ s|\.html$||;  # Intermodule links end with .html
    }

    # XXX Unimplemented
    # $pod =~ s/^f::/-f /;    # If we specify /f/ as our "base", it's a function search

    return $pod;
}

1;

=head1 AUTHOR

Andy Lester <andy@petdance.com>, adapted from Apache::Perldoc by
Rich Bowen <rbowen@ApacheAdmin.com>

=head1 LICENSE

This package is licensed under the same terms as Perl itself.

=cut
