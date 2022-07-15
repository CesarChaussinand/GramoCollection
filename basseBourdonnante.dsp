declare name            "Basse bourdonnante";
declare version         "1.0";
declare author          "César Chaussinand";
declare license         "MIT";
declare copyright       "(c) César Chaussinand 2022";
import("stdfaust.lib");

process = os.triangle(bourdon)+os.square(freq):fi.resonlp(fcut,3,vol):ef.cubicnl(0,0);

bourdon = hslider("fréquence du bourdon[knob:2]",55,30,60,1):qu.quantize(110,qu.eolian);
freq = hslider("fréquence[acc: 0 0 -9 0 9]",80,55,130,1):qu.quantize(110,qu.eolian);
fcut = hslider("fréquence de coupure du filtre[acc:1 0 -9 0 9]", 200,100,500,1);
vol = button("gate[switch:1]"):en.asr(0.1,1,0.1);
