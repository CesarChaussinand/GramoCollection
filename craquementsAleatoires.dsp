declare name            "Craquements aléatoires";
declare version         "1.0";
declare author          "César Chaussinand";
declare license         "MIT";
declare copyright       "(c) César Chaussinand 2022";

import("stdfaust.lib");

process = rPulse(rate):en.ar(0.001,0.005)*no.noise:pm.marimbaModel(freq,0)*gate:fx;

rPulse(r) = ba.pulse((no.noise:ba.latch(ba.pulse(3000))*0.5+1.1)*(1-r)*40000+1500);
fx = _<:_*(1-mix)+bitReducer(2)*(mix);
bitReducer(bits) = _*(pow(2,bits)):int(_)/pow(2,bits);

rate = hslider("rate[acc:0 0 -10 0 10]",0,0,1,0.01):sqrt;
freq = hslider("fréquence[acc:1 0 -10 0 10]",50,50,200,1):qu.quantize(110,qu.eolian);
gate = button("gate[switch:1]"):en.asr(0.1,1,0.1);
mix = hslider("fx mix[knob:2]",0.5,0,1,0.01);
