declare name            "Basse vibrante";
declare version         "1.0";
declare author          "César Chaussinand";
declare license         "MIT";
declare copyright       "(c) César Chaussinand 2022";

import("stdfaust.lib");

process = os.sawtooth(freq * vib) : fi.resonlp(env*300+100,5,env) : hardClip(clip);

hardClip(l) = min(l,max(-l,_));

freq = hslider("freq[acc: 0 0 -9 0 9]",80,50,150,1):qu.quantize(220,qu.eolian):si.smoo;
vib = (100+os.osc(rate)*depth)/100;
rate = 4+0.3*depth;
depth = hslider("vibrato depth[acc: 1 0 -9 0 9]",0,0,6,0.1);
env = button("note[switch:1]"):en.adsr(0.1,0,1,0.1);
clip = hslider("clip level[knob:2]",0.5,0,1,0.01);
