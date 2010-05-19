VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "virtex2p"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL Clk
        SIGNAL Clk_en
        SIGNAL Reset_en
        SIGNAL ac97_sdata_i
        SIGNAL ac97_bitclk
        SIGNAL L_o(15:0)
        SIGNAL R_o(15:0)
        SIGNAL cmd_addr(7:0)
        SIGNAL cmd_data(15:0)
        SIGNAL Frequency(10:0)
        SIGNAL XLXN_24(15:0)
        SIGNAL XLXN_25(15:0)
        SIGNAL XLXN_28
        SIGNAL XLXN_29
        SIGNAL XLXN_30
        SIGNAL XLXN_33
        SIGNAL XLXN_36(15:0)
        SIGNAL XLXN_37(15:0)
        PORT Input Clk
        PORT Input Clk_en
        PORT Input Reset_en
        PORT Input ac97_sdata_i
        PORT Input ac97_bitclk
        PORT Input L_o(15:0)
        PORT Input R_o(15:0)
        PORT Input cmd_addr(7:0)
        PORT Input cmd_data(15:0)
        PORT Output Frequency(10:0)
        BEGIN BLOCKDEF dc97
            TIMESTAMP 2010 5 14 13 23 20
            RECTANGLE N 64 -512 416 0 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            RECTANGLE N 0 -236 64 -212 
            LINE N 64 -224 0 -224 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 416 -480 480 -480 
            LINE N 416 -400 480 -400 
            LINE N 416 -320 480 -320 
            LINE N 416 -240 480 -240 
            RECTANGLE N 416 -172 480 -148 
            LINE N 416 -160 480 -160 
            RECTANGLE N 416 -92 480 -68 
            LINE N 416 -80 480 -80 
        END BLOCKDEF
        BEGIN BLOCKDEF filter
            TIMESTAMP 2010 5 19 12 36 13
            RECTANGLE N 64 -256 320 0 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            RECTANGLE N 320 -236 384 -212 
            LINE N 320 -224 384 -224 
        END BLOCKDEF
        BEGIN BLOCKDEF FreqCalc
            TIMESTAMP 2010 5 19 12 37 15
            RECTANGLE N 64 -128 464 0 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            RECTANGLE N 464 -108 528 -84 
            LINE N 464 -96 528 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF LevelDetector
            TIMESTAMP 2010 5 19 12 37 7
            RECTANGLE N 64 -64 400 0 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 400 -32 464 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF Timer
            TIMESTAMP 2010 5 19 12 36 57
            RECTANGLE N 64 -192 448 0 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            RECTANGLE N 448 -172 512 -148 
            LINE N 448 -160 512 -160 
        END BLOCKDEF
        BEGIN BLOCKDEF ZeroCrossingsDetector
            TIMESTAMP 2010 5 19 12 36 47
            RECTANGLE N 64 -128 448 0 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 448 -96 512 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF Counter
            TIMESTAMP 2010 5 19 12 37 21
            RECTANGLE N 64 -192 448 0 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 448 -160 512 -160 
            RECTANGLE N 448 -44 512 -20 
            LINE N 448 -32 512 -32 
        END BLOCKDEF
        BEGIN BLOCK XLXI_1 dc97
            PIN reset_n Reset_en
            PIN clk Clk
            PIN ac97_sdata_i ac97_sdata_i
            PIN ac97_bitclk ac97_bitclk
            PIN L_o(15:0) L_o(15:0)
            PIN R_o(15:0) R_o(15:0)
            PIN cmd_addr(7:0) cmd_addr(7:0)
            PIN cmd_data(15:0) cmd_data(15:0)
            PIN ac97_sdata_o
            PIN ac97_sync
            PIN ac97_reset
            PIN ready XLXN_30
            PIN L_i(15:0)
            PIN R_i(15:0) XLXN_24(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_2 filter
            PIN ready XLXN_30
            PIN clk_en Clk_en
            PIN reset_n Reset_en
            PIN R_i(15:0) XLXN_24(15:0)
            PIN filter_out(15:0) XLXN_25(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_4 LevelDetector
            PIN Filter_out(15:0) XLXN_25(15:0)
            PIN StartCounter XLXN_29
        END BLOCK
        BEGIN BLOCK XLXI_5 Timer
            PIN Clk Clk
            PIN StartCounter XLXN_29
            PIN ReachedTarget XLXN_33
            PIN SampleTime(15:0) XLXN_37(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_6 ZeroCrossingsDetector
            PIN ready XLXN_30
            PIN Filter_out(15:0) XLXN_25(15:0)
            PIN CrossingDetected XLXN_28
        END BLOCK
        BEGIN BLOCK XLXI_7 Counter
            PIN ready XLXN_30
            PIN StartCounter XLXN_29
            PIN CrossingDetected XLXN_28
            PIN ReachedTarget XLXN_33
            PIN Count(15:0) XLXN_36(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_3 FreqCalc
            PIN SampleTime(15:0) XLXN_37(15:0)
            PIN Count(15:0) XLXN_36(15:0)
            PIN Frequency(10:0) Frequency(10:0)
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN BRANCH Clk_en
            WIRE 640 800 656 800
            WIRE 656 800 656 816
            WIRE 656 816 1584 816
        END BRANCH
        IOMARKER 640 800 Clk_en R180 28
        BEGIN BRANCH Reset_en
            WIRE 640 960 800 960
            WIRE 800 960 800 1024
            WIRE 800 1024 960 1024
            WIRE 800 880 1584 880
            WIRE 800 880 800 960
        END BRANCH
        IOMARKER 640 960 Reset_en R180 28
        BEGIN INSTANCE XLXI_1 960 1504 R0
        END INSTANCE
        BEGIN BRANCH ac97_sdata_i
            WIRE 704 1152 960 1152
        END BRANCH
        IOMARKER 576 1088 Clk R180 28
        IOMARKER 704 1152 ac97_sdata_i R180 28
        IOMARKER 672 1216 ac97_bitclk R180 28
        BEGIN BRANCH ac97_bitclk
            WIRE 672 1216 960 1216
        END BRANCH
        IOMARKER 576 1280 L_o(15:0) R180 28
        BEGIN BRANCH L_o(15:0)
            WIRE 576 1280 960 1280
        END BRANCH
        IOMARKER 592 1344 R_o(15:0) R180 28
        BEGIN BRANCH R_o(15:0)
            WIRE 592 1344 960 1344
        END BRANCH
        IOMARKER 672 1408 cmd_addr(7:0) R180 28
        BEGIN BRANCH cmd_addr(7:0)
            WIRE 672 1408 960 1408
        END BRANCH
        BEGIN BRANCH cmd_data(15:0)
            WIRE 656 1472 960 1472
        END BRANCH
        IOMARKER 656 1472 cmd_data(15:0) R180 28
        BEGIN INSTANCE XLXI_2 1584 976 R0
        END INSTANCE
        BEGIN BRANCH XLXN_24(15:0)
            WIRE 1440 1424 1504 1424
            WIRE 1504 944 1504 1424
            WIRE 1504 944 1584 944
        END BRANCH
        BEGIN BRANCH XLXN_25(15:0)
            WIRE 1968 752 2048 752
            WIRE 2048 752 2096 752
            WIRE 2048 752 2048 1408
            WIRE 2048 1408 2080 1408
        END BRANCH
        BEGIN INSTANCE XLXI_4 2096 784 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_7 2704 1264 R0
        END INSTANCE
        BEGIN BRANCH XLXN_28
            WIRE 2592 1344 2688 1344
            WIRE 2688 1232 2704 1232
            WIRE 2688 1232 2688 1344
        END BRANCH
        BEGIN BRANCH XLXN_29
            WIRE 2560 752 2608 752
            WIRE 2608 752 2608 1168
            WIRE 2608 1168 2704 1168
            WIRE 2608 752 2976 752
        END BRANCH
        BEGIN BRANCH XLXN_30
            WIRE 1440 1264 1456 1264
            WIRE 1456 752 1584 752
            WIRE 1456 752 1456 1232
            WIRE 1456 1232 1456 1264
            WIRE 1456 1232 1776 1232
            WIRE 1776 1232 1776 1344
            WIRE 1776 1344 2080 1344
            WIRE 1776 1104 2704 1104
            WIRE 1776 1104 1776 1232
        END BRANCH
        BEGIN INSTANCE XLXI_6 2080 1440 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_5 2976 848 R0
        END INSTANCE
        BEGIN BRANCH XLXN_33
            WIRE 2896 816 2976 816
            WIRE 2896 816 2896 912
            WIRE 2896 912 3232 912
            WIRE 3232 912 3232 1104
            WIRE 3216 1104 3232 1104
        END BRANCH
        IOMARKER 3280 1408 Frequency(10:0) R0 28
        BEGIN INSTANCE XLXI_3 2672 1744 R0
        END INSTANCE
        BEGIN BRANCH Frequency(10:0)
            WIRE 3200 1648 3280 1648
            WIRE 3280 1408 3280 1648
        END BRANCH
        BEGIN BRANCH XLXN_36(15:0)
            WIRE 2592 1712 2672 1712
            WIRE 2592 1712 2592 1808
            WIRE 2592 1808 3232 1808
            WIRE 3216 1232 3232 1232
            WIRE 3232 1232 3232 1808
        END BRANCH
        BEGIN BRANCH XLXN_37(15:0)
            WIRE 2624 1488 2624 1648
            WIRE 2624 1648 2672 1648
            WIRE 2624 1488 3504 1488
            WIRE 3488 688 3504 688
            WIRE 3504 688 3504 1488
        END BRANCH
        BEGIN BRANCH Clk
            WIRE 576 1088 688 1088
            WIRE 688 1088 960 1088
            WIRE 688 528 688 1088
            WIRE 688 528 1184 528
            WIRE 1184 528 1200 528
            WIRE 1200 528 2992 528
            WIRE 2992 528 2992 592
            WIRE 2912 592 2912 688
            WIRE 2912 688 2976 688
            WIRE 2912 592 2992 592
        END BRANCH
    END SHEET
END SCHEMATIC
