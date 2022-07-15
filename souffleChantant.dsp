declare name            "Souffle chantant";
declare version         "1.0";
declare author          "César Chaussinand";
declare license         "MIT";
declare copyright       "(c) César Chaussinand 2022";

import("stdfaust.lib");

process = singing + wind : _*gate : ef.echo(0.2,0.2,0.5):ef.cubicnl(0,0);

singing = (os.osc(freq)+os.osc(@(freq*1.01,10000)))*vol;
wind = no.noise<:fi.resonbp(50+450*woosh,2,woosh),fi.resonbp(200+1050*woosh,6,woosh*highs):>_;

woosh = hslider("souffle[acc:0 0 -9 0 9]",0.3,0.1,1,0.01):si.smooth(0.9999)+vib;
vib = 0.2*os.osc(0.6);
highs = hslider("sifflement[acc:1 0 -9 0 9]",0.5,0,1,0.01):si.smooth(0.9999);
freq = hslider("fréquence[acc: 1 0 -9 0 9]",300,200,400,1):qu.quantize(220,qu.eolian):si.smoo;
vol = hslider("volume[knob:2]",0.3,0,0.4,0.01);
gate = button("gate[switch:1]"):en.asr(0.5,1,1);
