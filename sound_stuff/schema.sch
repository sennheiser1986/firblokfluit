VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "virtex2p"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_1
        SIGNAL XLXN_2(15:0)
        SIGNAL XLXN_7(15:0)
        SIGNAL XLXN_9(15:0)
        SIGNAL XLXN_11(15:0)
        SIGNAL XLXN_12(15:0)
        SIGNAL XLXN_13(15:0)
        SIGNAL XLXN_15
        SIGNAL XLXN_16
        SIGNAL XLXN_17
        SIGNAL XLXN_18(15:0)
        SIGNAL XLXN_19(15:0)
        SIGNAL XLXN_20
        SIGNAL XLXN_21
        SIGNAL XLXN_22
        SIGNAL XLXN_23(15:0)
        SIGNAL XLXN_24(15:0)
        SIGNAL XLXN_25
        SIGNAL XLXN_26
        SIGNAL XLXN_27
        SIGNAL XLXN_28
        SIGNAL XLXN_32
        SIGNAL XLXN_34(15:0)
        SIGNAL XLXN_35(15:0)
        SIGNAL XLXN_36(15:0)
        SIGNAL XLXN_37(15:0)
        SIGNAL XLXN_38(15:0)
        SIGNAL XLXN_39(15:0)
        SIGNAL XLXN_40(15:0)
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
        BEGIN BLOCKDEF LevelDetector
            TIMESTAMP 2010 5 19 12 37 7
            RECTANGLE N 64 -64 400 0 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 400 -32 464 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF ZeroCrossingsDetector
            TIMESTAMP 2010 5 19 12 36 47
            RECTANGLE N 64 -128 448 0 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 448 -96 512 -96 
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
        BEGIN BLOCK XLXI_1 dc97
            PIN reset_n
            PIN clk
            PIN ac97_sdata_i
            PIN ac97_bitclk
            PIN L_o(15:0)
            PIN R_o(15:0)
            PIN cmd_addr(7:0)
            PIN cmd_data(15:0)
            PIN ac97_sdata_o
            PIN ac97_sync
            PIN ac97_reset
            PIN ready XLXN_28
            PIN L_i(15:0)
            PIN R_i(15:0) XLXN_2(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_2 filter
            PIN ready XLXN_28
            PIN clk_en
            PIN reset_n
            PIN R_i(15:0) XLXN_2(15:0)
            PIN filter_out(15:0) XLXN_12(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_3 LevelDetector
            PIN Filter_out(15:0) XLXN_12(15:0)
            PIN StartCounter XLXN_20
        END BLOCK
        BEGIN BLOCK XLXI_4 ZeroCrossingsDetector
            PIN ready XLXN_28
            PIN Filter_out(15:0) XLXN_12(15:0)
            PIN CrossingDetected XLXN_26
        END BLOCK
        BEGIN BLOCK XLXI_6 Timer
            PIN Clk
            PIN StartCounter XLXN_20
            PIN ReachedTarget XLXN_25
            PIN SampleTime(15:0) XLXN_23(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_7 Counter
            PIN ready XLXN_28
            PIN StartCounter XLXN_20
            PIN CrossingDetected XLXN_26
            PIN ReachedTarget XLXN_25
            PIN Count(15:0) XLXN_24(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_8 FreqCalc
            PIN SampleTime(15:0) XLXN_23(15:0)
            PIN Count(15:0) XLXN_24(15:0)
            PIN Frequency(10:0)
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_1 416 912 R0
        END INSTANCE
        BEGIN BRANCH XLXN_2(15:0)
            WIRE 896 832 1104 832
        END BRANCH
        BEGIN BRANCH XLXN_12(15:0)
            WIRE 1488 640 1552 640
            WIRE 1552 384 1616 384
            WIRE 1552 384 1552 592
            WIRE 1552 592 1648 592
            WIRE 1552 592 1552 640
        END BRANCH
        BEGIN INSTANCE XLXI_4 1616 416 R0
        END INSTANCE
        BEGIN BRANCH XLXN_23(15:0)
            WIRE 2832 624 3424 624
            WIRE 2832 624 2832 864
            WIRE 2832 864 2912 864
            WIRE 3408 352 3424 352
            WIRE 3424 352 3424 624
        END BRANCH
        BEGIN BRANCH XLXN_24(15:0)
            WIRE 2736 928 2912 928
        END BRANCH
        BEGIN BRANCH XLXN_28
            WIRE 896 672 992 672
            WIRE 992 672 992 912
            WIRE 992 912 1552 912
            WIRE 992 320 1616 320
            WIRE 992 320 992 640
            WIRE 992 640 992 672
            WIRE 992 640 1104 640
            WIRE 1552 800 1552 912
            WIRE 1552 800 2224 800
        END BRANCH
        BEGIN BRANCH XLXN_26
            WIRE 2128 320 2176 320
            WIRE 2176 320 2176 928
            WIRE 2176 928 2224 928
        END BRANCH
        BEGIN BRANCH XLXN_20
            WIRE 2112 592 2144 592
            WIRE 2144 592 2512 592
            WIRE 2144 592 2144 864
            WIRE 2144 864 2224 864
            WIRE 2512 416 2896 416
            WIRE 2512 416 2512 592
        END BRANCH
        BEGIN INSTANCE XLXI_7 2224 960 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_6 2896 512 R0
        END INSTANCE
        BEGIN BRANCH XLXN_25
            WIRE 2736 800 2752 800
            WIRE 2752 480 2896 480
            WIRE 2752 480 2752 800
        END BRANCH
        BEGIN INSTANCE XLXI_8 2912 960 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_2 1104 864 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_3 1648 624 R0
        END INSTANCE
    END SHEET
END SCHEMATIC
