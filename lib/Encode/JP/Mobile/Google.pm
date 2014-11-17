package Encode::JP::Mobile::Google;
use 5.008005;
use strict;
use warnings;

use Encode::JP::Mobile qw(:props);
use Encode::JP::Emoji;
use base 'Encode::Encoding';
use Encode ();
sub needs_lines { 1 }
$Encode::Encoding{"x-utf8-e4u-mobile-google"} = bless { Name => "x-utf8-e4u-mobile-google" }, __PACKAGE__;

sub encode($$;$) {
    my ($self, $char, $check) = @_;
    my ($encoder, $decoder);
    if ($char =~/\p{InSoftBankPictograms}/) {
        $encoder = 'x-sjis-softbank-auto';
        $decoder = 'x-sjis-e4u-softbank3g';
    } elsif ($char =~/\p{InKDDIAutoPictograms}/) {
        $encoder = 'x-sjis-kddi-auto';
        $decoder = 'x-sjis-e4u-kddiweb';
    } elsif ($char =~/\p{InDoCoMoPictograms}/) {
        $encoder = 'x-sjis-docomo';
        $decoder = 'x-sjis-e4u-docomo';
    } else {
        $encoder = 'utf8';
        $decoder = 'utf8';
    }
    my $decoded_as_google = Encode::decode($decoder, Encode::encode($encoder, $char));
    return Encode::encode('x-utf8-e4u-google', $decoded_as_google);
}

sub decode($$;$) {
    my ($self, $char, $check) = @_; 
 
    return Encode::decode('x-sjis-softbank-auto', Encode::encode('x-sjis-e4u-softbank3g',Encode::decode('x-utf8-e4u-google', $char)));
}


1;
__END__

=encoding utf-8

=head1 NAME

Encode::JP::Mobile::E4U - It's new $module

=head1 SYNOPSIS

    use Encode::JP::Mobile::E4U;

=head1 DESCRIPTION

Encode::JP::Mobile::E4U is ...

=head1 LICENSE

Copyright (C) maedama.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

maedama E<lt>klemensplatz@gmail.comE<gt>

=cut

