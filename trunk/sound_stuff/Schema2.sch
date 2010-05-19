VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "virtex2p"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_12(15:0)
        SIGNAL XLXN_14(15:0)
        SIGNAL XLXN_16
        SIGNAL XLXN_19
        SIGNAL XLXN_21
        SIGNAL Clk
        SIGNAL Reset_n
        SIGNAL ac97_sdata_i
        SIGNAL ac97_bitclk
        SIGNAL L_o
        SIGNAL R_o
        SIGNAL cmd_data
        SIGNAL XLXN_2(15:0)
        SIGNAL XLXN_11(15:0)
        SIGNAL XLXN_39(15:0)
        SIGNAL XLXN_23(15:0)
        SIGNAL XLXN_41(15:0)
        SIGNAL XLXN_24(15:0)
        SIGNAL XLXN_43
        SIGNAL XLXN_28
        SIGNAL XLXN_26
        SIGNAL XLXN_46
        SIGNAL XLXN_20
        SIGNAL XLXN_48
        SIGNAL XLXN_25
        SIGNAL cmd_addr
        SIGNAL XLXN_58(15:0)
        SIGNAL XLXN_59(15:0)
        SIGNAL XLXN_60(7:0)
        SIGNAL XLXN_61(15:0)
        SIGNAL XLXN_63(15:0)
        SIGNAL XLXN_64(15:0)
        SIGNAL XLXN_65(7:0)
        SIGNAL XLXN_66(15:0)
        PORT Input Clk
        PORT Input Reset_n
        PORT Input ac97_sdata_i
        PORT Input ac97_bitclk
        PORT Input L_o
        PORT Input R_o
        PORT Input cmd_data
        PORT Input cmd_addr
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
        BEGIN BLOCKDEF Timer
            TIMESTAMP 2010 5 19 12 36 57
            RECTANGLE N 64 -192 448 0 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            RECTANGLE N 448 -172 512 -148 
            LINE N 448 -160 512 -160 
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
        BEGIN BLOCK XLXI_1 dc97
            PIN reset_n Reset_n
            PIN clk Clk
            PIN ac97_sdata_i ac97_sdata_i
            PIN ac97_bitclk ac97_bitclk
            PIN L_o(15:0) L_o
            PIN R_o(15:0) R_o
            PIN cmd_addr(7:0) cmd_addr
            PIN cmd_data(15:0) cmd_data
            PIN ac97_sdata_o
            PIN ac97_sync
            PIN ac97_reset
            PIN ready XLXN_28
            PIN L_i(15:0)
            PIN R_i(15:0) XLXN_2(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_2 ZeroCrossingsDetector
            PIN ready XLXN_28
            PIN Filter_out(15:0) XLXN_11(15:0)
            PIN CrossingDetected XLXN_26
        END BLOCK
        BEGIN BLOCK XLXI_3 Counter
            PIN ready XLXN_28
            PIN StartCounter XLXN_20
            PIN CrossingDetected XLXN_26
            PIN ReachedTarget XLXN_25
            PIN Count(15:0) XLXN_24(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_4 Timer
            PIN Clk
            PIN StartCounter XLXN_20
            PIN ReachedTarget XLXN_25
            PIN SampleTime(15:0) XLXN_23(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_8 FreqCalc
            PIN SampleTime(15:0) XLXN_23(15:0)
            PIN Count(15:0) XLXN_24(15:0)
            PIN Frequency(10:0)
        END BLOCK
        BEGIN BLOCK XLXI_7 LevelDetector
            PIN Filter_out(15:0) XLXN_11(15:0)
            PIN StartCounter XLXN_20
        END BLOCK
        BEGIN BLOCK XLXI_6 filter
            PIN ready XLXN_28
            PIN clk_en Clk
            PIN reset_n Reset_n
            PIN R_i(15:0) XLXN_2(15:0)
            PIN filter_out(15:0) XLXN_11(15:0)
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN BRANCH cmd_data
            WIRE 224 1360 480 1360
        END BRANCH
        BEGIN BRANCH XLXN_2(15:0)
            WIRE 960 1312 1104 1312
        END BRANCH
        BEGIN BRANCH XLXN_11(15:0)
            WIRE 1488 1120 1584 1120
            WIRE 1584 864 1648 864
            WIRE 1584 864 1584 1072
            WIRE 1584 1072 1680 1072
            WIRE 1584 1072 1584 1120
        END BRANCH
        BEGIN INSTANCE XLXI_2 1648 896 R0
        END INSTANCE
        BEGIN BRANCH XLXN_23(15:0)
            WIRE 2864 1104 3456 1104
            WIRE 2864 1104 2864 1344
            WIRE 2864 1344 2944 1344
            WIRE 3440 832 3456 832
            WIRE 3456 832 3456 1104
        END BRANCH
        BEGIN BRANCH XLXN_24(15:0)
            WIRE 2768 1408 2944 1408
        END BRANCH
        BEGIN BRANCH XLXN_26
            WIRE 2160 800 2208 800
            WIRE 2208 800 2208 1408
            WIRE 2208 1408 2256 1408
        END BRANCH
        BEGIN BRANCH XLXN_20
            WIRE 2144 1072 2176 1072
            WIRE 2176 1072 2544 1072
            WIRE 2176 1072 2176 1344
            WIRE 2176 1344 2256 1344
            WIRE 2544 896 2928 896
            WIRE 2544 896 2544 1072
        END BRANCH
        BEGIN INSTANCE XLXI_3 2256 1440 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_4 2928 992 R0
        END INSTANCE
        BEGIN BRANCH XLXN_25
            WIRE 2768 1280 2784 1280
            WIRE 2784 960 2928 960
            WIRE 2784 960 2784 1280
        END BRANCH
        BEGIN INSTANCE XLXI_8 2944 1440 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_7 1680 1104 R0
        END INSTANCE
        IOMARKER 3104 1568 "" R0 28
        BEGIN BRANCH cmd_addr
            WIRE 224 1296 480 1296
        END BRANCH
        IOMARKER 224 1296 cmd_addr R180 28
        BEGIN BRANCH R_o
            WIRE 160 1232 480 1232
        END BRANCH
        IOMARKER 160 1232 R_o R180 28
        IOMARKER 160 1168 L_o R180 28
        BEGIN BRANCH L_o
            WIRE 160 1168 480 1168
        END BRANCH
        IOMARKER 240 1104 ac97_bitclk R180 28
        BEGIN BRANCH XLXN_28
            WIRE 960 1152 1024 1152
            WIRE 1024 1152 1024 1392
            WIRE 1024 1392 1584 1392
            WIRE 1024 800 1648 800
            WIRE 1024 800 1024 1120
            WIRE 1024 1120 1024 1152
            WIRE 1024 1120 1104 1120
            WIRE 1584 1280 1584 1392
            WIRE 1584 1280 2256 1280
        END BRANCH
        BEGIN BRANCH ac97_bitclk
            WIRE 240 1104 480 1104
        END BRANCH
        BEGIN INSTANCE XLXI_1 480 1392 R0
        END INSTANCE
        IOMARKER 256 1040 ac97_sdata_i R180 28
        BEGIN BRANCH ac97_sdata_i
            WIRE 256 1040 480 1040
        END BRANCH
        IOMARKER 128 976 Clk R180 28
        BEGIN BRANCH Reset_n
            WIRE 192 912 384 912
            WIRE 384 912 480 912
            WIRE 384 912 384 1456
            WIRE 384 1456 1040 1456
            WIRE 1040 1248 1040 1456
            WIRE 1040 1248 1104 1248
        END BRANCH
        IOMARKER 192 912 Reset_n R180 28
        BEGIN INSTANCE XLXI_6 1104 1344 R0
        END INSTANCE
        IOMARKER 224 1360 cmd_data R180 28
        BEGIN BRANCH Clk
            WIRE 128 976 336 976
            WIRE 336 976 480 976
        END BRANCH
        BEGIN BRANCH Clk
            WIRE 1056 1184 1104 1184
        END BRANCH
    END SHEET
END SCHEMATIC
