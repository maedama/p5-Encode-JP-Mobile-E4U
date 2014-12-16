use strict;
use warnings;
use Test::More;
use Encode::JP::Mobile::E4U;

is $Encode::JP::Mobile::E4U::VERSION, "0.02", "version is 0.02";


subtest 'unicode' => sub {

    my $unicode_contents = "\x{2600}\x{2601}\x{2614}"; # unicode sun cloud rain
    my $softbank_contents = "\x{e04a}\x{e049}\x{e04b}"; # softbank sun cloud rain
    my $docomo_contents = "\x{E63E}\x{E63F}\x{E640}"; # docomo sun cloud rain
    my $unicode_first_quater_moon = "\x{263D}";

    my $unicode_utf8_contents = Encode::encode('utf8', $unicode_contents);
    my $softbank_utf8_contents = Encode::encode('utf8', $softbank_contents);
    my $docomo_utf8_contents = Encode::encode('utf8', $docomo_contents);
    
    my $unicode_utf8_first_quater_moon = "\x{263D}";

    subtest 'encode' => sub {
        is Encode::encode("x-utf8-e4u-mobile-unicode", $softbank_contents), $unicode_utf8_contents, "sofbtank pua should be encoded as unicode";
        is Encode::encode("x-utf8-e4u-mobile-unicode", $docomo_contents), $unicode_utf8_contents, "docomo pua should be encoded as unicode";
    };
    subtest "round trip" => sub {
        our %chars = (
            first_quater_moon => "\x{263D}",
            grinning_face => "\x{1f600}",
            smiling_face_with_open_mouth_and_cold_sweat => "\x{1f605}",
        );
        for my $name (keys %chars) {

            my $utf8 = Encode::encode('utf8', $chars{$name});
            note length($utf8);
            is Encode::encode('x-utf8-e4u-mobile-unicode', Encode::decode('x-utf8-e4u-mobile-unicode', $utf8)), $utf8, $name;
        }
    };
};


subtest 'google' => sub {
    my $google_contents = "\x{fe000}\x{fe001}\x{fe002}"; # google sun cloud rain
    my $softbank_contents = "\x{e04a}\x{e049}\x{e04b}"; # softbank sun cloud rain
    my $docomo_contents = "\x{E63E}\x{E63F}\x{E640}"; # docomo sun cloud rain

    my $google_utf8_contents = Encode::encode('utf8', $google_contents);
    my $softbank_utf8_contents = Encode::encode('utf8', $softbank_contents);
    my $docomo_utf8_contents = Encode::encode('utf8', $docomo_contents);

    subtest 'decode' => sub {
        is Encode::decode("x-utf8-e4u-mobile-google", $google_utf8_contents), $softbank_contents, "decode should be decoded as softbank pua";
    };

    subtest 'encode' => sub {
        is Encode::encode("x-utf8-e4u-mobile-google", $softbank_contents), $google_utf8_contents, "sofbtank pua should be encoded as google";
        is Encode::encode("x-utf8-e4u-mobile-google", $docomo_contents), $google_utf8_contents, "docomo pua should be encoded as google";
    };

};

done_testing;
