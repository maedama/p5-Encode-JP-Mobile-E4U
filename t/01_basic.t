use strict;
use warnings;
use Test::More;
use Encode::JP::Mobile::E4U;

subtest 'unicode' => sub {

    my $unicode_contents = "\x{2600}\x{2601}\x{2614}"; # unicode sun cloud rain
    my $softbank_contents = "\x{e04a}\x{e049}\x{e04b}"; # softbank sun cloud rain
    my $docomo_contents = "\x{E63E}\x{E63F}\x{E640}"; # docomo sun cloud rain

    my $unicode_utf8_contents = Encode::encode('utf8', $unicode_contents);
    my $softbank_utf8_contents = Encode::encode('utf8', $softbank_contents);
    my $docomo_utf8_contents = Encode::encode('utf8', $docomo_contents);

    subtest 'decode' => sub {
        is Encode::decode("x-utf8-e4u-mobile-unicode", $unicode_utf8_contents), $softbank_contents, "decode should be decoded as softbank pua";
    };

    subtest 'encode' => sub {
        is Encode::encode("x-utf8-e4u-mobile-unicode", $softbank_contents), $unicode_utf8_contents, "sofbtank pua should be encoded as unicode";
        is Encode::encode("x-utf8-e4u-mobile-unicode", $docomo_contents), $unicode_utf8_contents, "docomo pua should be encoded as unicode";
    };

};

done_testing;
