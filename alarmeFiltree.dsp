declare name            "Alarme filtrée";
declare version         "1.0";
declare author          "César Chaussinand";
declare license         "MIT";
declare copyright       "(c) César Chaussinand 2022";

import("stdfaust.lib");

process = os.sawtooth(freq*lfo) : fi.resonlp(frcut,4,env) : ef.cubicnl(0,0);

lfo = 1.25 + (os.osc(rate)>=0)*0.25;

freq = hslider("fréquence de base[acc:0 0 -9 0 9]",270,180,360,1):qu.quantize(110,qu.eolian) * env;
rate = hslider("vitesse de l'oscillation[knob:2]",5,1,20,1);
frcut = hslider("frequence filtre[acc:1 0 -9 0 9]",500,100,2000,1)*(1+env);
env = button("trig[switch:1]"):en.asr(0.25,1,0.1);
