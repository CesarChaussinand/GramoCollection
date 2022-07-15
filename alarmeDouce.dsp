declare name            "Alarme douce";
declare version         "1.0";
declare author          "César Chaussinand";
declare license         "MIT";
declare copyright       "(c) César Chaussinand 2022";

import("stdfaust.lib");

process = sy.fm(frqs(note1),indices)*lfo,sy.fm(frqs(note2),indices)*(1-lfo):>_*gate;

frqs(f) = (f,3*f,5*f);
indices = (120,500);

note1 = hslider("fréquence n°1[acc:0 0 -9 0 9]",150,100,200,1):qu.quantize(110,qu.eolian):si.smoo;
note2 = hslider("fréquence n°2[acc:1 0 -9 0 9]",200,150,300,1):qu.quantize(110,qu.eolian):si.smoo;
gate = button("gate[switch:1]"):en.asr(0.2,1,0.5);

lfo = os.osc(rate)*0.5+0.5;
rate = hslider("lfo rate[knob:2]",3,1,10,0.1);
