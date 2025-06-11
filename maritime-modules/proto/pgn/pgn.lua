-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

local pgn_dissector = {}

NMEA_2000_61440 = require "maritime-modules.proto.pgn.pgn_61440"
NMEA_2000_65001 = require "maritime-modules.proto.pgn.pgn_65001"
NMEA_2000_65002 = require "maritime-modules.proto.pgn.pgn_65002"
NMEA_2000_65003 = require "maritime-modules.proto.pgn.pgn_65003"
NMEA_2000_65004 = require "maritime-modules.proto.pgn.pgn_65004"
NMEA_2000_65005 = require "maritime-modules.proto.pgn.pgn_65005"
NMEA_2000_65006 = require "maritime-modules.proto.pgn.pgn_65006"
NMEA_2000_65007 = require "maritime-modules.proto.pgn.pgn_65007"
NMEA_2000_65008 = require "maritime-modules.proto.pgn.pgn_65008"
NMEA_2000_65009 = require "maritime-modules.proto.pgn.pgn_65009"
NMEA_2000_65010 = require "maritime-modules.proto.pgn.pgn_65010"
NMEA_2000_65011 = require "maritime-modules.proto.pgn.pgn_65011"
NMEA_2000_65012 = require "maritime-modules.proto.pgn.pgn_65012"
NMEA_2000_65013 = require "maritime-modules.proto.pgn.pgn_65013"
NMEA_2000_65014 = require "maritime-modules.proto.pgn.pgn_65014"
NMEA_2000_65015 = require "maritime-modules.proto.pgn.pgn_65015"
NMEA_2000_65016 = require "maritime-modules.proto.pgn.pgn_65016"
NMEA_2000_65017 = require "maritime-modules.proto.pgn.pgn_65017"
NMEA_2000_65018 = require "maritime-modules.proto.pgn.pgn_65018"
NMEA_2000_65019 = require "maritime-modules.proto.pgn.pgn_65019"
NMEA_2000_65020 = require "maritime-modules.proto.pgn.pgn_65020"
NMEA_2000_65021 = require "maritime-modules.proto.pgn.pgn_65021"
NMEA_2000_65022 = require "maritime-modules.proto.pgn.pgn_65022"
NMEA_2000_65023 = require "maritime-modules.proto.pgn.pgn_65023"
NMEA_2000_65024 = require "maritime-modules.proto.pgn.pgn_65024"
NMEA_2000_65025 = require "maritime-modules.proto.pgn.pgn_65025"
NMEA_2000_65026 = require "maritime-modules.proto.pgn.pgn_65026"
NMEA_2000_65027 = require "maritime-modules.proto.pgn.pgn_65027"
NMEA_2000_65028 = require "maritime-modules.proto.pgn.pgn_65028"
NMEA_2000_65029 = require "maritime-modules.proto.pgn.pgn_65029"
NMEA_2000_65030 = require "maritime-modules.proto.pgn.pgn_65030"
NMEA_2000_65240 = require "maritime-modules.proto.pgn.pgn_65240"
NMEA_2000_126208 = require "maritime-modules.proto.pgn.pgn_126208"
NMEA_2000_126208 = require "maritime-modules.proto.pgn.pgn_126208"
NMEA_2000_126208 = require "maritime-modules.proto.pgn.pgn_126208"
NMEA_2000_126208 = require "maritime-modules.proto.pgn.pgn_126208"
NMEA_2000_126208 = require "maritime-modules.proto.pgn.pgn_126208"
NMEA_2000_126208 = require "maritime-modules.proto.pgn.pgn_126208"
NMEA_2000_126208 = require "maritime-modules.proto.pgn.pgn_126208"
NMEA_2000_126208 = require "maritime-modules.proto.pgn.pgn_126208"
NMEA_2000_126464 = require "maritime-modules.proto.pgn.pgn_126464"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126720 = require "maritime-modules.proto.pgn.pgn_126720"
NMEA_2000_126976 = require "maritime-modules.proto.pgn.pgn_126976"
NMEA_2000_126983 = require "maritime-modules.proto.pgn.pgn_126983"
NMEA_2000_126984 = require "maritime-modules.proto.pgn.pgn_126984"
NMEA_2000_126985 = require "maritime-modules.proto.pgn.pgn_126985"
NMEA_2000_126986 = require "maritime-modules.proto.pgn.pgn_126986"
NMEA_2000_126987 = require "maritime-modules.proto.pgn.pgn_126987"
NMEA_2000_126988 = require "maritime-modules.proto.pgn.pgn_126988"
NMEA_2000_126992 = require "maritime-modules.proto.pgn.pgn_126992"
NMEA_2000_126993 = require "maritime-modules.proto.pgn.pgn_126993"
NMEA_2000_126996 = require "maritime-modules.proto.pgn.pgn_126996"
NMEA_2000_126998 = require "maritime-modules.proto.pgn.pgn_126998"
NMEA_2000_127233 = require "maritime-modules.proto.pgn.pgn_127233"
NMEA_2000_127237 = require "maritime-modules.proto.pgn.pgn_127237"
NMEA_2000_127245 = require "maritime-modules.proto.pgn.pgn_127245"
NMEA_2000_127250 = require "maritime-modules.proto.pgn.pgn_127250"
NMEA_2000_127251 = require "maritime-modules.proto.pgn.pgn_127251"
NMEA_2000_127252 = require "maritime-modules.proto.pgn.pgn_127252"
NMEA_2000_127257 = require "maritime-modules.proto.pgn.pgn_127257"
NMEA_2000_127258 = require "maritime-modules.proto.pgn.pgn_127258"
NMEA_2000_127488 = require "maritime-modules.proto.pgn.pgn_127488"
NMEA_2000_127489 = require "maritime-modules.proto.pgn.pgn_127489"
NMEA_2000_127490 = require "maritime-modules.proto.pgn.pgn_127490"
NMEA_2000_127491 = require "maritime-modules.proto.pgn.pgn_127491"
NMEA_2000_127493 = require "maritime-modules.proto.pgn.pgn_127493"
NMEA_2000_127494 = require "maritime-modules.proto.pgn.pgn_127494"
NMEA_2000_127495 = require "maritime-modules.proto.pgn.pgn_127495"
NMEA_2000_127496 = require "maritime-modules.proto.pgn.pgn_127496"
NMEA_2000_127497 = require "maritime-modules.proto.pgn.pgn_127497"
NMEA_2000_127498 = require "maritime-modules.proto.pgn.pgn_127498"
NMEA_2000_127500 = require "maritime-modules.proto.pgn.pgn_127500"
NMEA_2000_127501 = require "maritime-modules.proto.pgn.pgn_127501"
NMEA_2000_127502 = require "maritime-modules.proto.pgn.pgn_127502"
NMEA_2000_127503 = require "maritime-modules.proto.pgn.pgn_127503"
NMEA_2000_127504 = require "maritime-modules.proto.pgn.pgn_127504"
NMEA_2000_127505 = require "maritime-modules.proto.pgn.pgn_127505"
NMEA_2000_127506 = require "maritime-modules.proto.pgn.pgn_127506"
NMEA_2000_127507 = require "maritime-modules.proto.pgn.pgn_127507"
NMEA_2000_127508 = require "maritime-modules.proto.pgn.pgn_127508"
NMEA_2000_127509 = require "maritime-modules.proto.pgn.pgn_127509"
NMEA_2000_127510 = require "maritime-modules.proto.pgn.pgn_127510"
NMEA_2000_127511 = require "maritime-modules.proto.pgn.pgn_127511"
NMEA_2000_127512 = require "maritime-modules.proto.pgn.pgn_127512"
NMEA_2000_127513 = require "maritime-modules.proto.pgn.pgn_127513"
NMEA_2000_127514 = require "maritime-modules.proto.pgn.pgn_127514"
NMEA_2000_127744 = require "maritime-modules.proto.pgn.pgn_127744"
NMEA_2000_127745 = require "maritime-modules.proto.pgn.pgn_127745"
NMEA_2000_127746 = require "maritime-modules.proto.pgn.pgn_127746"
NMEA_2000_127747 = require "maritime-modules.proto.pgn.pgn_127747"
NMEA_2000_127748 = require "maritime-modules.proto.pgn.pgn_127748"
NMEA_2000_127749 = require "maritime-modules.proto.pgn.pgn_127749"
NMEA_2000_127750 = require "maritime-modules.proto.pgn.pgn_127750"
NMEA_2000_127751 = require "maritime-modules.proto.pgn.pgn_127751"
NMEA_2000_128000 = require "maritime-modules.proto.pgn.pgn_128000"
NMEA_2000_128001 = require "maritime-modules.proto.pgn.pgn_128001"
NMEA_2000_128002 = require "maritime-modules.proto.pgn.pgn_128002"
NMEA_2000_128003 = require "maritime-modules.proto.pgn.pgn_128003"
NMEA_2000_128006 = require "maritime-modules.proto.pgn.pgn_128006"
NMEA_2000_128007 = require "maritime-modules.proto.pgn.pgn_128007"
NMEA_2000_128008 = require "maritime-modules.proto.pgn.pgn_128008"
NMEA_2000_128259 = require "maritime-modules.proto.pgn.pgn_128259"
NMEA_2000_128267 = require "maritime-modules.proto.pgn.pgn_128267"
NMEA_2000_128275 = require "maritime-modules.proto.pgn.pgn_128275"
NMEA_2000_128520 = require "maritime-modules.proto.pgn.pgn_128520"
NMEA_2000_128538 = require "maritime-modules.proto.pgn.pgn_128538"
NMEA_2000_128768 = require "maritime-modules.proto.pgn.pgn_128768"
NMEA_2000_128769 = require "maritime-modules.proto.pgn.pgn_128769"
NMEA_2000_128776 = require "maritime-modules.proto.pgn.pgn_128776"
NMEA_2000_128777 = require "maritime-modules.proto.pgn.pgn_128777"
NMEA_2000_128778 = require "maritime-modules.proto.pgn.pgn_128778"
NMEA_2000_128780 = require "maritime-modules.proto.pgn.pgn_128780"
NMEA_2000_129025 = require "maritime-modules.proto.pgn.pgn_129025"
NMEA_2000_129026 = require "maritime-modules.proto.pgn.pgn_129026"
NMEA_2000_129027 = require "maritime-modules.proto.pgn.pgn_129027"
NMEA_2000_129028 = require "maritime-modules.proto.pgn.pgn_129028"
NMEA_2000_129029 = require "maritime-modules.proto.pgn.pgn_129029"
NMEA_2000_129033 = require "maritime-modules.proto.pgn.pgn_129033"
NMEA_2000_129038 = require "maritime-modules.proto.pgn.pgn_129038"
NMEA_2000_129039 = require "maritime-modules.proto.pgn.pgn_129039"
NMEA_2000_129040 = require "maritime-modules.proto.pgn.pgn_129040"
NMEA_2000_129041 = require "maritime-modules.proto.pgn.pgn_129041"
NMEA_2000_129044 = require "maritime-modules.proto.pgn.pgn_129044"
NMEA_2000_129045 = require "maritime-modules.proto.pgn.pgn_129045"
NMEA_2000_129283 = require "maritime-modules.proto.pgn.pgn_129283"
NMEA_2000_129284 = require "maritime-modules.proto.pgn.pgn_129284"
NMEA_2000_129285 = require "maritime-modules.proto.pgn.pgn_129285"
NMEA_2000_129291 = require "maritime-modules.proto.pgn.pgn_129291"
NMEA_2000_129301 = require "maritime-modules.proto.pgn.pgn_129301"
NMEA_2000_129302 = require "maritime-modules.proto.pgn.pgn_129302"
NMEA_2000_129538 = require "maritime-modules.proto.pgn.pgn_129538"
NMEA_2000_129539 = require "maritime-modules.proto.pgn.pgn_129539"
NMEA_2000_129540 = require "maritime-modules.proto.pgn.pgn_129540"
NMEA_2000_129541 = require "maritime-modules.proto.pgn.pgn_129541"
NMEA_2000_129542 = require "maritime-modules.proto.pgn.pgn_129542"
NMEA_2000_129545 = require "maritime-modules.proto.pgn.pgn_129545"
NMEA_2000_129546 = require "maritime-modules.proto.pgn.pgn_129546"
NMEA_2000_129547 = require "maritime-modules.proto.pgn.pgn_129547"
NMEA_2000_129549 = require "maritime-modules.proto.pgn.pgn_129549"
NMEA_2000_129550 = require "maritime-modules.proto.pgn.pgn_129550"
NMEA_2000_129551 = require "maritime-modules.proto.pgn.pgn_129551"
NMEA_2000_129556 = require "maritime-modules.proto.pgn.pgn_129556"
NMEA_2000_129792 = require "maritime-modules.proto.pgn.pgn_129792"
NMEA_2000_129793 = require "maritime-modules.proto.pgn.pgn_129793"
NMEA_2000_129794 = require "maritime-modules.proto.pgn.pgn_129794"
NMEA_2000_129795 = require "maritime-modules.proto.pgn.pgn_129795"
NMEA_2000_129796 = require "maritime-modules.proto.pgn.pgn_129796"
NMEA_2000_129797 = require "maritime-modules.proto.pgn.pgn_129797"
NMEA_2000_129798 = require "maritime-modules.proto.pgn.pgn_129798"
NMEA_2000_129799 = require "maritime-modules.proto.pgn.pgn_129799"
NMEA_2000_129800 = require "maritime-modules.proto.pgn.pgn_129800"
NMEA_2000_129801 = require "maritime-modules.proto.pgn.pgn_129801"
NMEA_2000_129802 = require "maritime-modules.proto.pgn.pgn_129802"
NMEA_2000_129803 = require "maritime-modules.proto.pgn.pgn_129803"
NMEA_2000_129804 = require "maritime-modules.proto.pgn.pgn_129804"
NMEA_2000_129805 = require "maritime-modules.proto.pgn.pgn_129805"
NMEA_2000_129806 = require "maritime-modules.proto.pgn.pgn_129806"
NMEA_2000_129807 = require "maritime-modules.proto.pgn.pgn_129807"
NMEA_2000_129808 = require "maritime-modules.proto.pgn.pgn_129808"
NMEA_2000_129808 = require "maritime-modules.proto.pgn.pgn_129808"
NMEA_2000_129809 = require "maritime-modules.proto.pgn.pgn_129809"
NMEA_2000_129810 = require "maritime-modules.proto.pgn.pgn_129810"
NMEA_2000_130052 = require "maritime-modules.proto.pgn.pgn_130052"
NMEA_2000_130053 = require "maritime-modules.proto.pgn.pgn_130053"
NMEA_2000_130054 = require "maritime-modules.proto.pgn.pgn_130054"
NMEA_2000_130060 = require "maritime-modules.proto.pgn.pgn_130060"
NMEA_2000_130061 = require "maritime-modules.proto.pgn.pgn_130061"
NMEA_2000_130064 = require "maritime-modules.proto.pgn.pgn_130064"
NMEA_2000_130065 = require "maritime-modules.proto.pgn.pgn_130065"
NMEA_2000_130066 = require "maritime-modules.proto.pgn.pgn_130066"
NMEA_2000_130067 = require "maritime-modules.proto.pgn.pgn_130067"
NMEA_2000_130068 = require "maritime-modules.proto.pgn.pgn_130068"
NMEA_2000_130069 = require "maritime-modules.proto.pgn.pgn_130069"
NMEA_2000_130070 = require "maritime-modules.proto.pgn.pgn_130070"
NMEA_2000_130071 = require "maritime-modules.proto.pgn.pgn_130071"
NMEA_2000_130072 = require "maritime-modules.proto.pgn.pgn_130072"
NMEA_2000_130073 = require "maritime-modules.proto.pgn.pgn_130073"
NMEA_2000_130074 = require "maritime-modules.proto.pgn.pgn_130074"
NMEA_2000_130306 = require "maritime-modules.proto.pgn.pgn_130306"
NMEA_2000_130310 = require "maritime-modules.proto.pgn.pgn_130310"
NMEA_2000_130311 = require "maritime-modules.proto.pgn.pgn_130311"
NMEA_2000_130312 = require "maritime-modules.proto.pgn.pgn_130312"
NMEA_2000_130313 = require "maritime-modules.proto.pgn.pgn_130313"
NMEA_2000_130314 = require "maritime-modules.proto.pgn.pgn_130314"
NMEA_2000_130315 = require "maritime-modules.proto.pgn.pgn_130315"
NMEA_2000_130316 = require "maritime-modules.proto.pgn.pgn_130316"
NMEA_2000_130320 = require "maritime-modules.proto.pgn.pgn_130320"
NMEA_2000_130321 = require "maritime-modules.proto.pgn.pgn_130321"
NMEA_2000_130322 = require "maritime-modules.proto.pgn.pgn_130322"
NMEA_2000_130323 = require "maritime-modules.proto.pgn.pgn_130323"
NMEA_2000_130324 = require "maritime-modules.proto.pgn.pgn_130324"
NMEA_2000_130330 = require "maritime-modules.proto.pgn.pgn_130330"
NMEA_2000_130560 = require "maritime-modules.proto.pgn.pgn_130560"
NMEA_2000_130561 = require "maritime-modules.proto.pgn.pgn_130561"
NMEA_2000_130562 = require "maritime-modules.proto.pgn.pgn_130562"
NMEA_2000_130563 = require "maritime-modules.proto.pgn.pgn_130563"
NMEA_2000_130564 = require "maritime-modules.proto.pgn.pgn_130564"
NMEA_2000_130565 = require "maritime-modules.proto.pgn.pgn_130565"
NMEA_2000_130566 = require "maritime-modules.proto.pgn.pgn_130566"
NMEA_2000_130567 = require "maritime-modules.proto.pgn.pgn_130567"
NMEA_2000_130569 = require "maritime-modules.proto.pgn.pgn_130569"
NMEA_2000_130570 = require "maritime-modules.proto.pgn.pgn_130570"
NMEA_2000_130571 = require "maritime-modules.proto.pgn.pgn_130571"
NMEA_2000_130572 = require "maritime-modules.proto.pgn.pgn_130572"
NMEA_2000_130573 = require "maritime-modules.proto.pgn.pgn_130573"
NMEA_2000_130574 = require "maritime-modules.proto.pgn.pgn_130574"
NMEA_2000_130576 = require "maritime-modules.proto.pgn.pgn_130576"
NMEA_2000_130577 = require "maritime-modules.proto.pgn.pgn_130577"
NMEA_2000_130578 = require "maritime-modules.proto.pgn.pgn_130578"
NMEA_2000_130579 = require "maritime-modules.proto.pgn.pgn_130579"
NMEA_2000_130580 = require "maritime-modules.proto.pgn.pgn_130580"
NMEA_2000_130581 = require "maritime-modules.proto.pgn.pgn_130581"
NMEA_2000_130582 = require "maritime-modules.proto.pgn.pgn_130582"
NMEA_2000_130583 = require "maritime-modules.proto.pgn.pgn_130583"
NMEA_2000_130584 = require "maritime-modules.proto.pgn.pgn_130584"
NMEA_2000_130585 = require "maritime-modules.proto.pgn.pgn_130585"
NMEA_2000_130586 = require "maritime-modules.proto.pgn.pgn_130586"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130816 = require "maritime-modules.proto.pgn.pgn_130816"
NMEA_2000_130818 = require "maritime-modules.proto.pgn.pgn_130818"
NMEA_2000_130819 = require "maritime-modules.proto.pgn.pgn_130819"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130820 = require "maritime-modules.proto.pgn.pgn_130820"
NMEA_2000_130821 = require "maritime-modules.proto.pgn.pgn_130821"
NMEA_2000_130821 = require "maritime-modules.proto.pgn.pgn_130821"
NMEA_2000_130822 = require "maritime-modules.proto.pgn.pgn_130822"
NMEA_2000_130823 = require "maritime-modules.proto.pgn.pgn_130823"
NMEA_2000_130824 = require "maritime-modules.proto.pgn.pgn_130824"
NMEA_2000_130824 = require "maritime-modules.proto.pgn.pgn_130824"
NMEA_2000_130825 = require "maritime-modules.proto.pgn.pgn_130825"
NMEA_2000_130827 = require "maritime-modules.proto.pgn.pgn_130827"
NMEA_2000_130828 = require "maritime-modules.proto.pgn.pgn_130828"
NMEA_2000_130831 = require "maritime-modules.proto.pgn.pgn_130831"
NMEA_2000_130832 = require "maritime-modules.proto.pgn.pgn_130832"
NMEA_2000_130833 = require "maritime-modules.proto.pgn.pgn_130833"
NMEA_2000_130834 = require "maritime-modules.proto.pgn.pgn_130834"
NMEA_2000_130835 = require "maritime-modules.proto.pgn.pgn_130835"
NMEA_2000_130836 = require "maritime-modules.proto.pgn.pgn_130836"
NMEA_2000_130836 = require "maritime-modules.proto.pgn.pgn_130836"
NMEA_2000_130837 = require "maritime-modules.proto.pgn.pgn_130837"
NMEA_2000_130837 = require "maritime-modules.proto.pgn.pgn_130837"
NMEA_2000_130838 = require "maritime-modules.proto.pgn.pgn_130838"
NMEA_2000_130839 = require "maritime-modules.proto.pgn.pgn_130839"
NMEA_2000_130840 = require "maritime-modules.proto.pgn.pgn_130840"
NMEA_2000_130842 = require "maritime-modules.proto.pgn.pgn_130842"
NMEA_2000_130842 = require "maritime-modules.proto.pgn.pgn_130842"
NMEA_2000_130842 = require "maritime-modules.proto.pgn.pgn_130842"
NMEA_2000_130843 = require "maritime-modules.proto.pgn.pgn_130843"
NMEA_2000_130843 = require "maritime-modules.proto.pgn.pgn_130843"
NMEA_2000_130845 = require "maritime-modules.proto.pgn.pgn_130845"
NMEA_2000_130845 = require "maritime-modules.proto.pgn.pgn_130845"
NMEA_2000_130846 = require "maritime-modules.proto.pgn.pgn_130846"
NMEA_2000_130846 = require "maritime-modules.proto.pgn.pgn_130846"
NMEA_2000_130847 = require "maritime-modules.proto.pgn.pgn_130847"
NMEA_2000_130848 = require "maritime-modules.proto.pgn.pgn_130848"
NMEA_2000_130850 = require "maritime-modules.proto.pgn.pgn_130850"
NMEA_2000_130850 = require "maritime-modules.proto.pgn.pgn_130850"
NMEA_2000_130850 = require "maritime-modules.proto.pgn.pgn_130850"
NMEA_2000_130851 = require "maritime-modules.proto.pgn.pgn_130851"
NMEA_2000_130856 = require "maritime-modules.proto.pgn.pgn_130856"
NMEA_2000_130860 = require "maritime-modules.proto.pgn.pgn_130860"
NMEA_2000_130880 = require "maritime-modules.proto.pgn.pgn_130880"
NMEA_2000_130881 = require "maritime-modules.proto.pgn.pgn_130881"
NMEA_2000_130918 = require "maritime-modules.proto.pgn.pgn_130918"
NMEA_2000_130944 = require "maritime-modules.proto.pgn.pgn_130944"

function pgn_dissector.dissector(buffer, pinfo, tree, pgn)
    if pgn == 61440 then
        NMEA_2000_61440.dissector(buffer, pinfo, tree)
    elseif pgn == 65001 then
        NMEA_2000_65001.dissector(buffer, pinfo, tree)
    elseif pgn == 65002 then
        NMEA_2000_65002.dissector(buffer, pinfo, tree)
    elseif pgn == 65003 then
        NMEA_2000_65003.dissector(buffer, pinfo, tree)
    elseif pgn == 65004 then
        NMEA_2000_65004.dissector(buffer, pinfo, tree)
    elseif pgn == 65005 then
        NMEA_2000_65005.dissector(buffer, pinfo, tree)
    elseif pgn == 65006 then
        NMEA_2000_65006.dissector(buffer, pinfo, tree)
    elseif pgn == 65007 then
        NMEA_2000_65007.dissector(buffer, pinfo, tree)
    elseif pgn == 65008 then
        NMEA_2000_65008.dissector(buffer, pinfo, tree)
    elseif pgn == 65009 then
        NMEA_2000_65009.dissector(buffer, pinfo, tree)
    elseif pgn == 65010 then
        NMEA_2000_65010.dissector(buffer, pinfo, tree)
    elseif pgn == 65011 then
        NMEA_2000_65011.dissector(buffer, pinfo, tree)
    elseif pgn == 65012 then
        NMEA_2000_65012.dissector(buffer, pinfo, tree)
    elseif pgn == 65013 then
        NMEA_2000_65013.dissector(buffer, pinfo, tree)
    elseif pgn == 65014 then
        NMEA_2000_65014.dissector(buffer, pinfo, tree)
    elseif pgn == 65015 then
        NMEA_2000_65015.dissector(buffer, pinfo, tree)
    elseif pgn == 65016 then
        NMEA_2000_65016.dissector(buffer, pinfo, tree)
    elseif pgn == 65017 then
        NMEA_2000_65017.dissector(buffer, pinfo, tree)
    elseif pgn == 65018 then
        NMEA_2000_65018.dissector(buffer, pinfo, tree)
    elseif pgn == 65019 then
        NMEA_2000_65019.dissector(buffer, pinfo, tree)
    elseif pgn == 65020 then
        NMEA_2000_65020.dissector(buffer, pinfo, tree)
    elseif pgn == 65021 then
        NMEA_2000_65021.dissector(buffer, pinfo, tree)
    elseif pgn == 65022 then
        NMEA_2000_65022.dissector(buffer, pinfo, tree)
    elseif pgn == 65023 then
        NMEA_2000_65023.dissector(buffer, pinfo, tree)
    elseif pgn == 65024 then
        NMEA_2000_65024.dissector(buffer, pinfo, tree)
    elseif pgn == 65025 then
        NMEA_2000_65025.dissector(buffer, pinfo, tree)
    elseif pgn == 65026 then
        NMEA_2000_65026.dissector(buffer, pinfo, tree)
    elseif pgn == 65027 then
        NMEA_2000_65027.dissector(buffer, pinfo, tree)
    elseif pgn == 65028 then
        NMEA_2000_65028.dissector(buffer, pinfo, tree)
    elseif pgn == 65029 then
        NMEA_2000_65029.dissector(buffer, pinfo, tree)
    elseif pgn == 65030 then
        NMEA_2000_65030.dissector(buffer, pinfo, tree)
    elseif pgn == 65240 then
        NMEA_2000_65240.dissector(buffer, pinfo, tree)
    elseif pgn == 126208 then
        NMEA_2000_126208.dissector(buffer, pinfo, tree)
    elseif pgn == 126208 then
        NMEA_2000_126208.dissector(buffer, pinfo, tree)
    elseif pgn == 126208 then
        NMEA_2000_126208.dissector(buffer, pinfo, tree)
    elseif pgn == 126208 then
        NMEA_2000_126208.dissector(buffer, pinfo, tree)
    elseif pgn == 126208 then
        NMEA_2000_126208.dissector(buffer, pinfo, tree)
    elseif pgn == 126208 then
        NMEA_2000_126208.dissector(buffer, pinfo, tree)
    elseif pgn == 126208 then
        NMEA_2000_126208.dissector(buffer, pinfo, tree)
    elseif pgn == 126208 then
        NMEA_2000_126208.dissector(buffer, pinfo, tree)
    elseif pgn == 126464 then
        NMEA_2000_126464.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126720 then
        NMEA_2000_126720.dissector(buffer, pinfo, tree)
    elseif pgn == 126976 then
        NMEA_2000_126976.dissector(buffer, pinfo, tree)
    elseif pgn == 126983 then
        NMEA_2000_126983.dissector(buffer, pinfo, tree)
    elseif pgn == 126984 then
        NMEA_2000_126984.dissector(buffer, pinfo, tree)
    elseif pgn == 126985 then
        NMEA_2000_126985.dissector(buffer, pinfo, tree)
    elseif pgn == 126986 then
        NMEA_2000_126986.dissector(buffer, pinfo, tree)
    elseif pgn == 126987 then
        NMEA_2000_126987.dissector(buffer, pinfo, tree)
    elseif pgn == 126988 then
        NMEA_2000_126988.dissector(buffer, pinfo, tree)
    elseif pgn == 126992 then
        NMEA_2000_126992.dissector(buffer, pinfo, tree)
    elseif pgn == 126993 then
        NMEA_2000_126993.dissector(buffer, pinfo, tree)
    elseif pgn == 126996 then
        NMEA_2000_126996.dissector(buffer, pinfo, tree)
    elseif pgn == 126998 then
        NMEA_2000_126998.dissector(buffer, pinfo, tree)
    elseif pgn == 127233 then
        NMEA_2000_127233.dissector(buffer, pinfo, tree)
    elseif pgn == 127237 then
        NMEA_2000_127237.dissector(buffer, pinfo, tree)
    elseif pgn == 127245 then
        NMEA_2000_127245.dissector(buffer, pinfo, tree)
    elseif pgn == 127250 then
        NMEA_2000_127250.dissector(buffer, pinfo, tree)
    elseif pgn == 127251 then
        NMEA_2000_127251.dissector(buffer, pinfo, tree)
    elseif pgn == 127252 then
        NMEA_2000_127252.dissector(buffer, pinfo, tree)
    elseif pgn == 127257 then
        NMEA_2000_127257.dissector(buffer, pinfo, tree)
    elseif pgn == 127258 then
        NMEA_2000_127258.dissector(buffer, pinfo, tree)
    elseif pgn == 127488 then
        NMEA_2000_127488.dissector(buffer, pinfo, tree)
    elseif pgn == 127489 then
        NMEA_2000_127489.dissector(buffer, pinfo, tree)
    elseif pgn == 127490 then
        NMEA_2000_127490.dissector(buffer, pinfo, tree)
    elseif pgn == 127491 then
        NMEA_2000_127491.dissector(buffer, pinfo, tree)
    elseif pgn == 127493 then
        NMEA_2000_127493.dissector(buffer, pinfo, tree)
    elseif pgn == 127494 then
        NMEA_2000_127494.dissector(buffer, pinfo, tree)
    elseif pgn == 127495 then
        NMEA_2000_127495.dissector(buffer, pinfo, tree)
    elseif pgn == 127496 then
        NMEA_2000_127496.dissector(buffer, pinfo, tree)
    elseif pgn == 127497 then
        NMEA_2000_127497.dissector(buffer, pinfo, tree)
    elseif pgn == 127498 then
        NMEA_2000_127498.dissector(buffer, pinfo, tree)
    elseif pgn == 127500 then
        NMEA_2000_127500.dissector(buffer, pinfo, tree)
    elseif pgn == 127501 then
        NMEA_2000_127501.dissector(buffer, pinfo, tree)
    elseif pgn == 127502 then
        NMEA_2000_127502.dissector(buffer, pinfo, tree)
    elseif pgn == 127503 then
        NMEA_2000_127503.dissector(buffer, pinfo, tree)
    elseif pgn == 127504 then
        NMEA_2000_127504.dissector(buffer, pinfo, tree)
    elseif pgn == 127505 then
        NMEA_2000_127505.dissector(buffer, pinfo, tree)
    elseif pgn == 127506 then
        NMEA_2000_127506.dissector(buffer, pinfo, tree)
    elseif pgn == 127507 then
        NMEA_2000_127507.dissector(buffer, pinfo, tree)
    elseif pgn == 127508 then
        NMEA_2000_127508.dissector(buffer, pinfo, tree)
    elseif pgn == 127509 then
        NMEA_2000_127509.dissector(buffer, pinfo, tree)
    elseif pgn == 127510 then
        NMEA_2000_127510.dissector(buffer, pinfo, tree)
    elseif pgn == 127511 then
        NMEA_2000_127511.dissector(buffer, pinfo, tree)
    elseif pgn == 127512 then
        NMEA_2000_127512.dissector(buffer, pinfo, tree)
    elseif pgn == 127513 then
        NMEA_2000_127513.dissector(buffer, pinfo, tree)
    elseif pgn == 127514 then
        NMEA_2000_127514.dissector(buffer, pinfo, tree)
    elseif pgn == 127744 then
        NMEA_2000_127744.dissector(buffer, pinfo, tree)
    elseif pgn == 127745 then
        NMEA_2000_127745.dissector(buffer, pinfo, tree)
    elseif pgn == 127746 then
        NMEA_2000_127746.dissector(buffer, pinfo, tree)
    elseif pgn == 127747 then
        NMEA_2000_127747.dissector(buffer, pinfo, tree)
    elseif pgn == 127748 then
        NMEA_2000_127748.dissector(buffer, pinfo, tree)
    elseif pgn == 127749 then
        NMEA_2000_127749.dissector(buffer, pinfo, tree)
    elseif pgn == 127750 then
        NMEA_2000_127750.dissector(buffer, pinfo, tree)
    elseif pgn == 127751 then
        NMEA_2000_127751.dissector(buffer, pinfo, tree)
    elseif pgn == 128000 then
        NMEA_2000_128000.dissector(buffer, pinfo, tree)
    elseif pgn == 128001 then
        NMEA_2000_128001.dissector(buffer, pinfo, tree)
    elseif pgn == 128002 then
        NMEA_2000_128002.dissector(buffer, pinfo, tree)
    elseif pgn == 128003 then
        NMEA_2000_128003.dissector(buffer, pinfo, tree)
    elseif pgn == 128006 then
        NMEA_2000_128006.dissector(buffer, pinfo, tree)
    elseif pgn == 128007 then
        NMEA_2000_128007.dissector(buffer, pinfo, tree)
    elseif pgn == 128008 then
        NMEA_2000_128008.dissector(buffer, pinfo, tree)
    elseif pgn == 128259 then
        NMEA_2000_128259.dissector(buffer, pinfo, tree)
    elseif pgn == 128267 then
        NMEA_2000_128267.dissector(buffer, pinfo, tree)
    elseif pgn == 128275 then
        NMEA_2000_128275.dissector(buffer, pinfo, tree)
    elseif pgn == 128520 then
        NMEA_2000_128520.dissector(buffer, pinfo, tree)
    elseif pgn == 128538 then
        NMEA_2000_128538.dissector(buffer, pinfo, tree)
    elseif pgn == 128768 then
        NMEA_2000_128768.dissector(buffer, pinfo, tree)
    elseif pgn == 128769 then
        NMEA_2000_128769.dissector(buffer, pinfo, tree)
    elseif pgn == 128776 then
        NMEA_2000_128776.dissector(buffer, pinfo, tree)
    elseif pgn == 128777 then
        NMEA_2000_128777.dissector(buffer, pinfo, tree)
    elseif pgn == 128778 then
        NMEA_2000_128778.dissector(buffer, pinfo, tree)
    elseif pgn == 128780 then
        NMEA_2000_128780.dissector(buffer, pinfo, tree)
    elseif pgn == 129025 then
        NMEA_2000_129025.dissector(buffer, pinfo, tree)
    elseif pgn == 129026 then
        NMEA_2000_129026.dissector(buffer, pinfo, tree)
    elseif pgn == 129027 then
        NMEA_2000_129027.dissector(buffer, pinfo, tree)
    elseif pgn == 129028 then
        NMEA_2000_129028.dissector(buffer, pinfo, tree)
    elseif pgn == 129029 then
        NMEA_2000_129029.dissector(buffer, pinfo, tree)
    elseif pgn == 129033 then
        NMEA_2000_129033.dissector(buffer, pinfo, tree)
    elseif pgn == 129038 then
        NMEA_2000_129038.dissector(buffer, pinfo, tree)
    elseif pgn == 129039 then
        NMEA_2000_129039.dissector(buffer, pinfo, tree)
    elseif pgn == 129040 then
        NMEA_2000_129040.dissector(buffer, pinfo, tree)
    elseif pgn == 129041 then
        NMEA_2000_129041.dissector(buffer, pinfo, tree)
    elseif pgn == 129044 then
        NMEA_2000_129044.dissector(buffer, pinfo, tree)
    elseif pgn == 129045 then
        NMEA_2000_129045.dissector(buffer, pinfo, tree)
    elseif pgn == 129283 then
        NMEA_2000_129283.dissector(buffer, pinfo, tree)
    elseif pgn == 129284 then
        NMEA_2000_129284.dissector(buffer, pinfo, tree)
    elseif pgn == 129285 then
        NMEA_2000_129285.dissector(buffer, pinfo, tree)
    elseif pgn == 129291 then
        NMEA_2000_129291.dissector(buffer, pinfo, tree)
    elseif pgn == 129301 then
        NMEA_2000_129301.dissector(buffer, pinfo, tree)
    elseif pgn == 129302 then
        NMEA_2000_129302.dissector(buffer, pinfo, tree)
    elseif pgn == 129538 then
        NMEA_2000_129538.dissector(buffer, pinfo, tree)
    elseif pgn == 129539 then
        NMEA_2000_129539.dissector(buffer, pinfo, tree)
    elseif pgn == 129540 then
        NMEA_2000_129540.dissector(buffer, pinfo, tree)
    elseif pgn == 129541 then
        NMEA_2000_129541.dissector(buffer, pinfo, tree)
    elseif pgn == 129542 then
        NMEA_2000_129542.dissector(buffer, pinfo, tree)
    elseif pgn == 129545 then
        NMEA_2000_129545.dissector(buffer, pinfo, tree)
    elseif pgn == 129546 then
        NMEA_2000_129546.dissector(buffer, pinfo, tree)
    elseif pgn == 129547 then
        NMEA_2000_129547.dissector(buffer, pinfo, tree)
    elseif pgn == 129549 then
        NMEA_2000_129549.dissector(buffer, pinfo, tree)
    elseif pgn == 129550 then
        NMEA_2000_129550.dissector(buffer, pinfo, tree)
    elseif pgn == 129551 then
        NMEA_2000_129551.dissector(buffer, pinfo, tree)
    elseif pgn == 129556 then
        NMEA_2000_129556.dissector(buffer, pinfo, tree)
    elseif pgn == 129792 then
        NMEA_2000_129792.dissector(buffer, pinfo, tree)
    elseif pgn == 129793 then
        NMEA_2000_129793.dissector(buffer, pinfo, tree)
    elseif pgn == 129794 then
        NMEA_2000_129794.dissector(buffer, pinfo, tree)
    elseif pgn == 129795 then
        NMEA_2000_129795.dissector(buffer, pinfo, tree)
    elseif pgn == 129796 then
        NMEA_2000_129796.dissector(buffer, pinfo, tree)
    elseif pgn == 129797 then
        NMEA_2000_129797.dissector(buffer, pinfo, tree)
    elseif pgn == 129798 then
        NMEA_2000_129798.dissector(buffer, pinfo, tree)
    elseif pgn == 129799 then
        NMEA_2000_129799.dissector(buffer, pinfo, tree)
    elseif pgn == 129800 then
        NMEA_2000_129800.dissector(buffer, pinfo, tree)
    elseif pgn == 129801 then
        NMEA_2000_129801.dissector(buffer, pinfo, tree)
    elseif pgn == 129802 then
        NMEA_2000_129802.dissector(buffer, pinfo, tree)
    elseif pgn == 129803 then
        NMEA_2000_129803.dissector(buffer, pinfo, tree)
    elseif pgn == 129804 then
        NMEA_2000_129804.dissector(buffer, pinfo, tree)
    elseif pgn == 129805 then
        NMEA_2000_129805.dissector(buffer, pinfo, tree)
    elseif pgn == 129806 then
        NMEA_2000_129806.dissector(buffer, pinfo, tree)
    elseif pgn == 129807 then
        NMEA_2000_129807.dissector(buffer, pinfo, tree)
    elseif pgn == 129808 then
        NMEA_2000_129808.dissector(buffer, pinfo, tree)
    elseif pgn == 129808 then
        NMEA_2000_129808.dissector(buffer, pinfo, tree)
    elseif pgn == 129809 then
        NMEA_2000_129809.dissector(buffer, pinfo, tree)
    elseif pgn == 129810 then
        NMEA_2000_129810.dissector(buffer, pinfo, tree)
    elseif pgn == 130052 then
        NMEA_2000_130052.dissector(buffer, pinfo, tree)
    elseif pgn == 130053 then
        NMEA_2000_130053.dissector(buffer, pinfo, tree)
    elseif pgn == 130054 then
        NMEA_2000_130054.dissector(buffer, pinfo, tree)
    elseif pgn == 130060 then
        NMEA_2000_130060.dissector(buffer, pinfo, tree)
    elseif pgn == 130061 then
        NMEA_2000_130061.dissector(buffer, pinfo, tree)
    elseif pgn == 130064 then
        NMEA_2000_130064.dissector(buffer, pinfo, tree)
    elseif pgn == 130065 then
        NMEA_2000_130065.dissector(buffer, pinfo, tree)
    elseif pgn == 130066 then
        NMEA_2000_130066.dissector(buffer, pinfo, tree)
    elseif pgn == 130067 then
        NMEA_2000_130067.dissector(buffer, pinfo, tree)
    elseif pgn == 130068 then
        NMEA_2000_130068.dissector(buffer, pinfo, tree)
    elseif pgn == 130069 then
        NMEA_2000_130069.dissector(buffer, pinfo, tree)
    elseif pgn == 130070 then
        NMEA_2000_130070.dissector(buffer, pinfo, tree)
    elseif pgn == 130071 then
        NMEA_2000_130071.dissector(buffer, pinfo, tree)
    elseif pgn == 130072 then
        NMEA_2000_130072.dissector(buffer, pinfo, tree)
    elseif pgn == 130073 then
        NMEA_2000_130073.dissector(buffer, pinfo, tree)
    elseif pgn == 130074 then
        NMEA_2000_130074.dissector(buffer, pinfo, tree)
    elseif pgn == 130306 then
        NMEA_2000_130306.dissector(buffer, pinfo, tree)
    elseif pgn == 130310 then
        NMEA_2000_130310.dissector(buffer, pinfo, tree)
    elseif pgn == 130311 then
        NMEA_2000_130311.dissector(buffer, pinfo, tree)
    elseif pgn == 130312 then
        NMEA_2000_130312.dissector(buffer, pinfo, tree)
    elseif pgn == 130313 then
        NMEA_2000_130313.dissector(buffer, pinfo, tree)
    elseif pgn == 130314 then
        NMEA_2000_130314.dissector(buffer, pinfo, tree)
    elseif pgn == 130315 then
        NMEA_2000_130315.dissector(buffer, pinfo, tree)
    elseif pgn == 130316 then
        NMEA_2000_130316.dissector(buffer, pinfo, tree)
    elseif pgn == 130320 then
        NMEA_2000_130320.dissector(buffer, pinfo, tree)
    elseif pgn == 130321 then
        NMEA_2000_130321.dissector(buffer, pinfo, tree)
    elseif pgn == 130322 then
        NMEA_2000_130322.dissector(buffer, pinfo, tree)
    elseif pgn == 130323 then
        NMEA_2000_130323.dissector(buffer, pinfo, tree)
    elseif pgn == 130324 then
        NMEA_2000_130324.dissector(buffer, pinfo, tree)
    elseif pgn == 130330 then
        NMEA_2000_130330.dissector(buffer, pinfo, tree)
    elseif pgn == 130560 then
        NMEA_2000_130560.dissector(buffer, pinfo, tree)
    elseif pgn == 130561 then
        NMEA_2000_130561.dissector(buffer, pinfo, tree)
    elseif pgn == 130562 then
        NMEA_2000_130562.dissector(buffer, pinfo, tree)
    elseif pgn == 130563 then
        NMEA_2000_130563.dissector(buffer, pinfo, tree)
    elseif pgn == 130564 then
        NMEA_2000_130564.dissector(buffer, pinfo, tree)
    elseif pgn == 130565 then
        NMEA_2000_130565.dissector(buffer, pinfo, tree)
    elseif pgn == 130566 then
        NMEA_2000_130566.dissector(buffer, pinfo, tree)
    elseif pgn == 130567 then
        NMEA_2000_130567.dissector(buffer, pinfo, tree)
    elseif pgn == 130569 then
        NMEA_2000_130569.dissector(buffer, pinfo, tree)
    elseif pgn == 130570 then
        NMEA_2000_130570.dissector(buffer, pinfo, tree)
    elseif pgn == 130571 then
        NMEA_2000_130571.dissector(buffer, pinfo, tree)
    elseif pgn == 130572 then
        NMEA_2000_130572.dissector(buffer, pinfo, tree)
    elseif pgn == 130573 then
        NMEA_2000_130573.dissector(buffer, pinfo, tree)
    elseif pgn == 130574 then
        NMEA_2000_130574.dissector(buffer, pinfo, tree)
    elseif pgn == 130576 then
        NMEA_2000_130576.dissector(buffer, pinfo, tree)
    elseif pgn == 130577 then
        NMEA_2000_130577.dissector(buffer, pinfo, tree)
    elseif pgn == 130578 then
        NMEA_2000_130578.dissector(buffer, pinfo, tree)
    elseif pgn == 130579 then
        NMEA_2000_130579.dissector(buffer, pinfo, tree)
    elseif pgn == 130580 then
        NMEA_2000_130580.dissector(buffer, pinfo, tree)
    elseif pgn == 130581 then
        NMEA_2000_130581.dissector(buffer, pinfo, tree)
    elseif pgn == 130582 then
        NMEA_2000_130582.dissector(buffer, pinfo, tree)
    elseif pgn == 130583 then
        NMEA_2000_130583.dissector(buffer, pinfo, tree)
    elseif pgn == 130584 then
        NMEA_2000_130584.dissector(buffer, pinfo, tree)
    elseif pgn == 130585 then
        NMEA_2000_130585.dissector(buffer, pinfo, tree)
    elseif pgn == 130586 then
        NMEA_2000_130586.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130816 then
        NMEA_2000_130816.dissector(buffer, pinfo, tree)
    elseif pgn == 130818 then
        NMEA_2000_130818.dissector(buffer, pinfo, tree)
    elseif pgn == 130819 then
        NMEA_2000_130819.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130820 then
        NMEA_2000_130820.dissector(buffer, pinfo, tree)
    elseif pgn == 130821 then
        NMEA_2000_130821.dissector(buffer, pinfo, tree)
    elseif pgn == 130821 then
        NMEA_2000_130821.dissector(buffer, pinfo, tree)
    elseif pgn == 130822 then
        NMEA_2000_130822.dissector(buffer, pinfo, tree)
    elseif pgn == 130823 then
        NMEA_2000_130823.dissector(buffer, pinfo, tree)
    elseif pgn == 130824 then
        NMEA_2000_130824.dissector(buffer, pinfo, tree)
    elseif pgn == 130824 then
        NMEA_2000_130824.dissector(buffer, pinfo, tree)
    elseif pgn == 130825 then
        NMEA_2000_130825.dissector(buffer, pinfo, tree)
    elseif pgn == 130827 then
        NMEA_2000_130827.dissector(buffer, pinfo, tree)
    elseif pgn == 130828 then
        NMEA_2000_130828.dissector(buffer, pinfo, tree)
    elseif pgn == 130831 then
        NMEA_2000_130831.dissector(buffer, pinfo, tree)
    elseif pgn == 130832 then
        NMEA_2000_130832.dissector(buffer, pinfo, tree)
    elseif pgn == 130833 then
        NMEA_2000_130833.dissector(buffer, pinfo, tree)
    elseif pgn == 130834 then
        NMEA_2000_130834.dissector(buffer, pinfo, tree)
    elseif pgn == 130835 then
        NMEA_2000_130835.dissector(buffer, pinfo, tree)
    elseif pgn == 130836 then
        NMEA_2000_130836.dissector(buffer, pinfo, tree)
    elseif pgn == 130836 then
        NMEA_2000_130836.dissector(buffer, pinfo, tree)
    elseif pgn == 130837 then
        NMEA_2000_130837.dissector(buffer, pinfo, tree)
    elseif pgn == 130837 then
        NMEA_2000_130837.dissector(buffer, pinfo, tree)
    elseif pgn == 130838 then
        NMEA_2000_130838.dissector(buffer, pinfo, tree)
    elseif pgn == 130839 then
        NMEA_2000_130839.dissector(buffer, pinfo, tree)
    elseif pgn == 130840 then
        NMEA_2000_130840.dissector(buffer, pinfo, tree)
    elseif pgn == 130842 then
        NMEA_2000_130842.dissector(buffer, pinfo, tree)
    elseif pgn == 130842 then
        NMEA_2000_130842.dissector(buffer, pinfo, tree)
    elseif pgn == 130842 then
        NMEA_2000_130842.dissector(buffer, pinfo, tree)
    elseif pgn == 130843 then
        NMEA_2000_130843.dissector(buffer, pinfo, tree)
    elseif pgn == 130843 then
        NMEA_2000_130843.dissector(buffer, pinfo, tree)
    elseif pgn == 130845 then
        NMEA_2000_130845.dissector(buffer, pinfo, tree)
    elseif pgn == 130845 then
        NMEA_2000_130845.dissector(buffer, pinfo, tree)
    elseif pgn == 130846 then
        NMEA_2000_130846.dissector(buffer, pinfo, tree)
    elseif pgn == 130846 then
        NMEA_2000_130846.dissector(buffer, pinfo, tree)
    elseif pgn == 130847 then
        NMEA_2000_130847.dissector(buffer, pinfo, tree)
    elseif pgn == 130848 then
        NMEA_2000_130848.dissector(buffer, pinfo, tree)
    elseif pgn == 130850 then
        NMEA_2000_130850.dissector(buffer, pinfo, tree)
    elseif pgn == 130850 then
        NMEA_2000_130850.dissector(buffer, pinfo, tree)
    elseif pgn == 130850 then
        NMEA_2000_130850.dissector(buffer, pinfo, tree)
    elseif pgn == 130851 then
        NMEA_2000_130851.dissector(buffer, pinfo, tree)
    elseif pgn == 130856 then
        NMEA_2000_130856.dissector(buffer, pinfo, tree)
    elseif pgn == 130860 then
        NMEA_2000_130860.dissector(buffer, pinfo, tree)
    elseif pgn == 130880 then
        NMEA_2000_130880.dissector(buffer, pinfo, tree)
    elseif pgn == 130881 then
        NMEA_2000_130881.dissector(buffer, pinfo, tree)
    elseif pgn == 130918 then
        NMEA_2000_130918.dissector(buffer, pinfo, tree)
    elseif pgn == 130944 then
        NMEA_2000_130944.dissector(buffer, pinfo, tree)
    else
        return false
    end

    return true
end

return pgn_dissector