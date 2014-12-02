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

my $fb_callback = Encode::JP::Mobile::FB_CHARACTER(sub { chr(shift);});

sub encode($$;$) {
    my ($self, $char, $check) = @_;
    Encode::encode('x-utf8-e4u-google', Encode::decode('x-utf8-e4u-softbank3g', Encode::encode("x-utf8-softbank", $char, $fb_callback)), $fb_callback);
}

sub decode($$;$) {
    my ($self, $char, $check) = @_; 
 
    my $res = Encode::decode('utf8', Encode::encode('x-utf8-e4u-softbank3g',Encode::decode('x-utf8-e4u-google', $char)));
    if ($Encode::JP::Mobile::E4U::REPLACE_4BYTE_UTF8_CHARS) {
        $res =~s/[\x{10000}-\x{3ffff}\x{40000}-\x{fffff}\x{100000}-\x{10ffff}]/\x{3013}/g;
    }
    return $res;
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

