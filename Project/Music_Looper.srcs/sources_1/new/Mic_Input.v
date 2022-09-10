`timescale 1ns / 1ps

module Mic_Input(
    output reg [15:0] aux_data,
    input micData,
    input Clk
    );

    parameter kHZCnt = 5120;    // 16*320
    parameter leastValue = 2720;  // 16*170
    parameter bgNum = 60;
    
    wire pwm_val_reg;
    wire pwm_val_reg_1,pwm_val_reg_2,pwm_val_reg_3,pwm_val_reg_4,pwm_val_reg_5;
    wire pwm_val_reg_6,pwm_val_reg_7,pwm_val_reg_8,pwm_val_reg_9,pwm_val_reg_10;
    wire pwm_val_reg_11,pwm_val_reg_12,pwm_val_reg_13,pwm_val_reg_14,pwm_val_reg_15;
    wire pwm_val_reg_16,pwm_val_reg_17,pwm_val_reg_18,pwm_val_reg_19,pwm_val_reg_20;
    wire pwm_val_reg_21,pwm_val_reg_22,pwm_val_reg_23,pwm_val_reg_24,pwm_val_reg_25;
    wire pwm_val_reg_26,pwm_val_reg_27,pwm_val_reg_28,pwm_val_reg_29,pwm_val_reg_30;
    wire pwm_val_reg_31,pwm_val_reg_32,pwm_val_reg_33,pwm_val_reg_34,pwm_val_reg_35;
    wire pwm_val_reg_36,pwm_val_reg_37,pwm_val_reg_38,pwm_val_reg_39,pwm_val_reg_40;
    wire pwm_val_reg_41,pwm_val_reg_42,pwm_val_reg_43,pwm_val_reg_44,pwm_val_reg_45;
    wire pwm_val_reg_46,pwm_val_reg_47,pwm_val_reg_48,pwm_val_reg_49,pwm_val_reg_50;
    wire pwm_val_reg_51,pwm_val_reg_52,pwm_val_reg_53,pwm_val_reg_54,pwm_val_reg_55;
    wire pwm_val_reg_56,pwm_val_reg_57,pwm_val_reg_58,pwm_val_reg_59,pwm_val_reg_60;/*
    wire pwm_val_reg_61,pwm_val_reg_62,pwm_val_reg_63,pwm_val_reg_64,pwm_val_reg_65;
    wire pwm_val_reg_66,pwm_val_reg_67,pwm_val_reg_68,pwm_val_reg_69,pwm_val_reg_70;
    wire pwm_val_reg_71,pwm_val_reg_72,pwm_val_reg_73,pwm_val_reg_74,pwm_val_reg_75;
    wire pwm_val_reg_76,pwm_val_reg_77,pwm_val_reg_78,pwm_val_reg_79,pwm_val_reg_80;*/
    
    defparam geter_01.Begin_kHZ_Cnt = kHZCnt*0/bgNum, geter_02.Begin_kHZ_Cnt = kHZCnt*1/bgNum, geter_03.Begin_kHZ_Cnt = kHZCnt*2/bgNum,
             geter_04.Begin_kHZ_Cnt = kHZCnt*3/bgNum, geter_05.Begin_kHZ_Cnt = kHZCnt*4/bgNum, geter_06.Begin_kHZ_Cnt = kHZCnt*5/bgNum,
             geter_07.Begin_kHZ_Cnt = kHZCnt*6/bgNum, geter_08.Begin_kHZ_Cnt = kHZCnt*7/bgNum, geter_09.Begin_kHZ_Cnt = kHZCnt*8/bgNum,
             geter_10.Begin_kHZ_Cnt = kHZCnt*9/bgNum, geter_11.Begin_kHZ_Cnt = kHZCnt*10/bgNum, geter_12.Begin_kHZ_Cnt = kHZCnt*11/bgNum,
             geter_13.Begin_kHZ_Cnt = kHZCnt*12/bgNum, geter_14.Begin_kHZ_Cnt = kHZCnt*13/bgNum, geter_15.Begin_kHZ_Cnt = kHZCnt*14/bgNum,
             geter_16.Begin_kHZ_Cnt = kHZCnt*15/bgNum, geter_17.Begin_kHZ_Cnt = kHZCnt*16/bgNum, geter_18.Begin_kHZ_Cnt = kHZCnt*17/bgNum,
             geter_19.Begin_kHZ_Cnt = kHZCnt*18/bgNum, geter_20.Begin_kHZ_Cnt = kHZCnt*19/bgNum, geter_21.Begin_kHZ_Cnt = kHZCnt*20/bgNum,
             geter_22.Begin_kHZ_Cnt = kHZCnt*21/bgNum, geter_23.Begin_kHZ_Cnt = kHZCnt*22/bgNum, geter_24.Begin_kHZ_Cnt = kHZCnt*23/bgNum,
             geter_25.Begin_kHZ_Cnt = kHZCnt*24/bgNum, geter_26.Begin_kHZ_Cnt = kHZCnt*25/bgNum, geter_27.Begin_kHZ_Cnt = kHZCnt*26/bgNum,
             geter_28.Begin_kHZ_Cnt = kHZCnt*27/bgNum, geter_29.Begin_kHZ_Cnt = kHZCnt*28/bgNum, geter_30.Begin_kHZ_Cnt = kHZCnt*29/bgNum,
             geter_31.Begin_kHZ_Cnt = kHZCnt*30/bgNum, geter_32.Begin_kHZ_Cnt = kHZCnt*31/bgNum, geter_33.Begin_kHZ_Cnt = kHZCnt*32/bgNum,
             geter_34.Begin_kHZ_Cnt = kHZCnt*33/bgNum, geter_35.Begin_kHZ_Cnt = kHZCnt*34/bgNum, geter_36.Begin_kHZ_Cnt = kHZCnt*35/bgNum,
             geter_37.Begin_kHZ_Cnt = kHZCnt*36/bgNum, geter_38.Begin_kHZ_Cnt = kHZCnt*37/bgNum, geter_39.Begin_kHZ_Cnt = kHZCnt*38/bgNum,
             geter_40.Begin_kHZ_Cnt = kHZCnt*39/bgNum, geter_41.Begin_kHZ_Cnt = kHZCnt*40/bgNum, geter_42.Begin_kHZ_Cnt = kHZCnt*41/bgNum,
             geter_43.Begin_kHZ_Cnt = kHZCnt*42/bgNum, geter_44.Begin_kHZ_Cnt = kHZCnt*43/bgNum, geter_45.Begin_kHZ_Cnt = kHZCnt*44/bgNum,
             geter_46.Begin_kHZ_Cnt = kHZCnt*45/bgNum, geter_47.Begin_kHZ_Cnt = kHZCnt*46/bgNum, geter_48.Begin_kHZ_Cnt = kHZCnt*47/bgNum,
             geter_49.Begin_kHZ_Cnt = kHZCnt*48/bgNum, geter_50.Begin_kHZ_Cnt = kHZCnt*49/bgNum, geter_51.Begin_kHZ_Cnt = kHZCnt*50/bgNum,
             geter_52.Begin_kHZ_Cnt = kHZCnt*51/bgNum, geter_53.Begin_kHZ_Cnt = kHZCnt*52/bgNum, geter_54.Begin_kHZ_Cnt = kHZCnt*53/bgNum,
             geter_55.Begin_kHZ_Cnt = kHZCnt*54/bgNum, geter_56.Begin_kHZ_Cnt = kHZCnt*55/bgNum, geter_57.Begin_kHZ_Cnt = kHZCnt*56/bgNum,
             geter_58.Begin_kHZ_Cnt = kHZCnt*57/bgNum, geter_59.Begin_kHZ_Cnt = kHZCnt*58/bgNum, geter_60.Begin_kHZ_Cnt = kHZCnt*59/bgNum;
             /*geter_61.Begin_kHZ_Cnt = kHZCnt*60/bgNum, geter_62.Begin_kHZ_Cnt = kHZCnt*61/bgNum, geter_63.Begin_kHZ_Cnt = kHZCnt*62/bgNum,
             geter_64.Begin_kHZ_Cnt = kHZCnt*61/bgNum, geter_65.Begin_kHZ_Cnt = kHZCnt*64/bgNum, geter_66.Begin_kHZ_Cnt = kHZCnt*65/bgNum,
             geter_67.Begin_kHZ_Cnt = kHZCnt*64/bgNum, geter_68.Begin_kHZ_Cnt = kHZCnt*67/bgNum, geter_69.Begin_kHZ_Cnt = kHZCnt*68/bgNum,
             geter_70.Begin_kHZ_Cnt = kHZCnt*67/bgNum, geter_71.Begin_kHZ_Cnt = kHZCnt*70/bgNum, geter_72.Begin_kHZ_Cnt = kHZCnt*71/bgNum,
             geter_73.Begin_kHZ_Cnt = kHZCnt*70/bgNum, geter_74.Begin_kHZ_Cnt = kHZCnt*73/bgNum, geter_75.Begin_kHZ_Cnt = kHZCnt*74/bgNum,
             geter_76.Begin_kHZ_Cnt = kHZCnt*73/bgNum, geter_77.Begin_kHZ_Cnt = kHZCnt*76/bgNum, geter_78.Begin_kHZ_Cnt = kHZCnt*77/bgNum,
             geter_79.Begin_kHZ_Cnt = kHZCnt*76/bgNum, geter_80.Begin_kHZ_Cnt = kHZCnt*79/bgNum;*/
        
    Bit_Getter geter_01(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_1)); defparam geter_01.kHZ_Cnt = kHZCnt, geter_01.least_value = leastValue;
    Bit_Getter geter_02(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_2)); defparam geter_02.kHZ_Cnt = kHZCnt, geter_02.least_value = leastValue;
    Bit_Getter geter_03(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_3)); defparam geter_03.kHZ_Cnt = kHZCnt, geter_03.least_value = leastValue;
    Bit_Getter geter_04(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_4)); defparam geter_04.kHZ_Cnt = kHZCnt, geter_04.least_value = leastValue;
    Bit_Getter geter_05(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_5)); defparam geter_05.kHZ_Cnt = kHZCnt, geter_05.least_value = leastValue;
    Bit_Getter geter_06(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_6)); defparam geter_06.kHZ_Cnt = kHZCnt, geter_06.least_value = leastValue;
    Bit_Getter geter_07(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_7)); defparam geter_07.kHZ_Cnt = kHZCnt, geter_07.least_value = leastValue;
    Bit_Getter geter_08(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_8)); defparam geter_08.kHZ_Cnt = kHZCnt, geter_08.least_value = leastValue;
    Bit_Getter geter_09(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_9)); defparam geter_09.kHZ_Cnt = kHZCnt, geter_09.least_value = leastValue;
    Bit_Getter geter_10(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_10)); defparam geter_10.kHZ_Cnt = kHZCnt, geter_10.least_value = leastValue;
    Bit_Getter geter_11(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_11)); defparam geter_11.kHZ_Cnt = kHZCnt, geter_11.least_value = leastValue;
    Bit_Getter geter_12(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_12)); defparam geter_12.kHZ_Cnt = kHZCnt, geter_12.least_value = leastValue;
    Bit_Getter geter_13(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_13)); defparam geter_13.kHZ_Cnt = kHZCnt, geter_13.least_value = leastValue;
    Bit_Getter geter_14(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_14)); defparam geter_14.kHZ_Cnt = kHZCnt, geter_14.least_value = leastValue;
    Bit_Getter geter_15(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_15)); defparam geter_15.kHZ_Cnt = kHZCnt, geter_15.least_value = leastValue;
    Bit_Getter geter_16(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_16)); defparam geter_16.kHZ_Cnt = kHZCnt, geter_16.least_value = leastValue;
    Bit_Getter geter_17(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_17)); defparam geter_17.kHZ_Cnt = kHZCnt, geter_17.least_value = leastValue;
    Bit_Getter geter_18(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_18)); defparam geter_18.kHZ_Cnt = kHZCnt, geter_18.least_value = leastValue;
    Bit_Getter geter_19(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_19)); defparam geter_19.kHZ_Cnt = kHZCnt, geter_19.least_value = leastValue;
    Bit_Getter geter_20(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_20)); defparam geter_20.kHZ_Cnt = kHZCnt, geter_20.least_value = leastValue;
    Bit_Getter geter_21(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_21)); defparam geter_21.kHZ_Cnt = kHZCnt, geter_21.least_value = leastValue;
    Bit_Getter geter_22(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_22)); defparam geter_22.kHZ_Cnt = kHZCnt, geter_22.least_value = leastValue;
    Bit_Getter geter_23(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_23)); defparam geter_23.kHZ_Cnt = kHZCnt, geter_23.least_value = leastValue;
    Bit_Getter geter_24(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_24)); defparam geter_24.kHZ_Cnt = kHZCnt, geter_24.least_value = leastValue;
    Bit_Getter geter_25(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_25)); defparam geter_25.kHZ_Cnt = kHZCnt, geter_25.least_value = leastValue;
    Bit_Getter geter_26(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_26)); defparam geter_26.kHZ_Cnt = kHZCnt, geter_26.least_value = leastValue;
    Bit_Getter geter_27(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_27)); defparam geter_27.kHZ_Cnt = kHZCnt, geter_27.least_value = leastValue;
    Bit_Getter geter_28(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_28)); defparam geter_28.kHZ_Cnt = kHZCnt, geter_28.least_value = leastValue;
    Bit_Getter geter_29(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_29)); defparam geter_29.kHZ_Cnt = kHZCnt, geter_29.least_value = leastValue;
    Bit_Getter geter_30(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_30)); defparam geter_30.kHZ_Cnt = kHZCnt, geter_30.least_value = leastValue;
    Bit_Getter geter_31(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_31)); defparam geter_31.kHZ_Cnt = kHZCnt, geter_31.least_value = leastValue;
    Bit_Getter geter_32(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_32)); defparam geter_32.kHZ_Cnt = kHZCnt, geter_32.least_value = leastValue;
    Bit_Getter geter_33(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_33)); defparam geter_33.kHZ_Cnt = kHZCnt, geter_33.least_value = leastValue;
    Bit_Getter geter_34(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_34)); defparam geter_34.kHZ_Cnt = kHZCnt, geter_34.least_value = leastValue;
    Bit_Getter geter_35(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_35)); defparam geter_35.kHZ_Cnt = kHZCnt, geter_35.least_value = leastValue;
    Bit_Getter geter_36(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_36)); defparam geter_36.kHZ_Cnt = kHZCnt, geter_36.least_value = leastValue;
    Bit_Getter geter_37(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_37)); defparam geter_37.kHZ_Cnt = kHZCnt, geter_37.least_value = leastValue;
    Bit_Getter geter_38(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_38)); defparam geter_38.kHZ_Cnt = kHZCnt, geter_38.least_value = leastValue;
    Bit_Getter geter_39(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_39)); defparam geter_39.kHZ_Cnt = kHZCnt, geter_39.least_value = leastValue;
    Bit_Getter geter_40(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_40)); defparam geter_40.kHZ_Cnt = kHZCnt, geter_40.least_value = leastValue;
    Bit_Getter geter_41(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_41)); defparam geter_41.kHZ_Cnt = kHZCnt, geter_41.least_value = leastValue;
    Bit_Getter geter_42(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_42)); defparam geter_42.kHZ_Cnt = kHZCnt, geter_42.least_value = leastValue;
    Bit_Getter geter_43(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_43)); defparam geter_43.kHZ_Cnt = kHZCnt, geter_43.least_value = leastValue;
    Bit_Getter geter_44(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_44)); defparam geter_44.kHZ_Cnt = kHZCnt, geter_44.least_value = leastValue;
    Bit_Getter geter_45(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_45)); defparam geter_45.kHZ_Cnt = kHZCnt, geter_45.least_value = leastValue;
    Bit_Getter geter_46(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_46)); defparam geter_46.kHZ_Cnt = kHZCnt, geter_46.least_value = leastValue;
    Bit_Getter geter_47(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_47)); defparam geter_47.kHZ_Cnt = kHZCnt, geter_47.least_value = leastValue;
    Bit_Getter geter_48(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_48)); defparam geter_48.kHZ_Cnt = kHZCnt, geter_48.least_value = leastValue;
    Bit_Getter geter_49(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_49)); defparam geter_49.kHZ_Cnt = kHZCnt, geter_49.least_value = leastValue;
    Bit_Getter geter_50(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_50)); defparam geter_50.kHZ_Cnt = kHZCnt, geter_50.least_value = leastValue;
    Bit_Getter geter_51(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_51)); defparam geter_51.kHZ_Cnt = kHZCnt, geter_51.least_value = leastValue;
    Bit_Getter geter_52(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_52)); defparam geter_52.kHZ_Cnt = kHZCnt, geter_52.least_value = leastValue;
    Bit_Getter geter_53(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_53)); defparam geter_53.kHZ_Cnt = kHZCnt, geter_53.least_value = leastValue;
    Bit_Getter geter_54(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_54)); defparam geter_54.kHZ_Cnt = kHZCnt, geter_54.least_value = leastValue;
    Bit_Getter geter_55(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_55)); defparam geter_55.kHZ_Cnt = kHZCnt, geter_55.least_value = leastValue;
    Bit_Getter geter_56(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_56)); defparam geter_56.kHZ_Cnt = kHZCnt, geter_56.least_value = leastValue;
    Bit_Getter geter_57(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_57)); defparam geter_57.kHZ_Cnt = kHZCnt, geter_57.least_value = leastValue;
    Bit_Getter geter_58(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_58)); defparam geter_58.kHZ_Cnt = kHZCnt, geter_58.least_value = leastValue;
    Bit_Getter geter_59(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_59)); defparam geter_59.kHZ_Cnt = kHZCnt, geter_59.least_value = leastValue;
    Bit_Getter geter_60(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_60)); defparam geter_60.kHZ_Cnt = kHZCnt, geter_60.least_value = leastValue;
    /*Bit_Getter geter_61(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_61)); defparam geter_61.kHZ_Cnt = kHZCnt, geter_61.least_value = leastValue;
    Bit_Getter geter_62(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_62)); defparam geter_62.kHZ_Cnt = kHZCnt, geter_62.least_value = leastValue;
    Bit_Getter geter_63(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_63)); defparam geter_63.kHZ_Cnt = kHZCnt, geter_63.least_value = leastValue;
    Bit_Getter geter_64(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_64)); defparam geter_64.kHZ_Cnt = kHZCnt, geter_64.least_value = leastValue;
    Bit_Getter geter_65(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_65)); defparam geter_65.kHZ_Cnt = kHZCnt, geter_65.least_value = leastValue;
    Bit_Getter geter_66(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_66)); defparam geter_66.kHZ_Cnt = kHZCnt, geter_66.least_value = leastValue;
    Bit_Getter geter_67(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_67)); defparam geter_67.kHZ_Cnt = kHZCnt, geter_67.least_value = leastValue;
    Bit_Getter geter_68(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_68)); defparam geter_68.kHZ_Cnt = kHZCnt, geter_68.least_value = leastValue;
    Bit_Getter geter_69(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_69)); defparam geter_69.kHZ_Cnt = kHZCnt, geter_69.least_value = leastValue;
    Bit_Getter geter_70(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_70)); defparam geter_70.kHZ_Cnt = kHZCnt, geter_70.least_value = leastValue;
    Bit_Getter geter_71(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_71)); defparam geter_71.kHZ_Cnt = kHZCnt, geter_71.least_value = leastValue;
    Bit_Getter geter_72(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_72)); defparam geter_72.kHZ_Cnt = kHZCnt, geter_72.least_value = leastValue;
    Bit_Getter geter_73(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_73)); defparam geter_73.kHZ_Cnt = kHZCnt, geter_73.least_value = leastValue;
    Bit_Getter geter_74(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_74)); defparam geter_74.kHZ_Cnt = kHZCnt, geter_74.least_value = leastValue;
    Bit_Getter geter_75(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_75)); defparam geter_75.kHZ_Cnt = kHZCnt, geter_75.least_value = leastValue;
    Bit_Getter geter_76(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_76)); defparam geter_76.kHZ_Cnt = kHZCnt, geter_76.least_value = leastValue;
    Bit_Getter geter_77(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_77)); defparam geter_77.kHZ_Cnt = kHZCnt, geter_77.least_value = leastValue;
    Bit_Getter geter_78(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_78)); defparam geter_78.kHZ_Cnt = kHZCnt, geter_78.least_value = leastValue;
    Bit_Getter geter_79(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_79)); defparam geter_79.kHZ_Cnt = kHZCnt, geter_79.least_value = leastValue;
    Bit_Getter geter_80(.clk_100MHz(Clk),.micData(micData),.pwm_val(pwm_val_reg_80)); defparam geter_80.kHZ_Cnt = kHZCnt, geter_80.least_value = leastValue;*/
        
    assign pwm_val_reg=pwm_val_reg_1|pwm_val_reg_2|pwm_val_reg_3|pwm_val_reg_4|pwm_val_reg_5|
                    pwm_val_reg_6|pwm_val_reg_7|pwm_val_reg_8|pwm_val_reg_9|pwm_val_reg_10|
                    pwm_val_reg_11|pwm_val_reg_12|pwm_val_reg_13|pwm_val_reg_14|pwm_val_reg_15|
                    pwm_val_reg_16|pwm_val_reg_17|pwm_val_reg_18|pwm_val_reg_19|pwm_val_reg_20|
                    pwm_val_reg_21|pwm_val_reg_22|pwm_val_reg_23|pwm_val_reg_24|pwm_val_reg_25|
                    pwm_val_reg_26|pwm_val_reg_27|pwm_val_reg_28|pwm_val_reg_29|pwm_val_reg_30|
                    pwm_val_reg_31|pwm_val_reg_32|pwm_val_reg_33|pwm_val_reg_34|pwm_val_reg_35|
                    pwm_val_reg_36|pwm_val_reg_37|pwm_val_reg_38|pwm_val_reg_39|pwm_val_reg_40|
                    pwm_val_reg_41|pwm_val_reg_42|pwm_val_reg_43|pwm_val_reg_44|pwm_val_reg_45|
                    pwm_val_reg_46|pwm_val_reg_47|pwm_val_reg_48|pwm_val_reg_49|pwm_val_reg_50|
                    pwm_val_reg_51|pwm_val_reg_52|pwm_val_reg_53|pwm_val_reg_54|pwm_val_reg_55|
                    pwm_val_reg_56|pwm_val_reg_57|pwm_val_reg_58|pwm_val_reg_59|pwm_val_reg_60;//|
                    /*pwm_val_reg_61|pwm_val_reg_62|pwm_val_reg_63|pwm_val_reg_64|pwm_val_reg_65|
                    pwm_val_reg_66|pwm_val_reg_67|pwm_val_reg_68|pwm_val_reg_69|pwm_val_reg_70|
                    pwm_val_reg_71|pwm_val_reg_72|pwm_val_reg_73|pwm_val_reg_74|pwm_val_reg_75|
                    pwm_val_reg_76|pwm_val_reg_77|pwm_val_reg_78|pwm_val_reg_79|pwm_val_reg_80;*/
    
    always@(posedge Clk) begin
        aux_data <= {16{pwm_val_reg}};
    end
    
endmodule