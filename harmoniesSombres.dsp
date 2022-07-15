declare name            "Harmonies sombres";
declare version         "1.0";
declare author          "César Chaussinand";
declare license         "MIT";
declare copyright       "(c) César Chaussinand 2022";

import("stdfaust.lib");

process = os.osc(freq1),os.osc(freq2),os.osc(freq3) :> _ *env : ef.cubicnl(0,0);

freq1 = hslider("fréquence 1[knob:2]",120,80,160,1):qu.quantize(220,qu.eolian);
freq2 = hslider("fréquence 2[acc: 0 0 -9 0 9]",180,120,240,1):qu.quantize(220,qu.eolian);
freq3 = hslider("fréquence 3[acc: 1 0 -9 0 9]",320,180,360,1):qu.quantize(220,qu.eolian);
env = button("trig[switch:1]"):en.asr(0.1,0.35,0.5);
