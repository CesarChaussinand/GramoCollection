declare name            "Grognement  contrôlé";
declare version         "1.0";
declare author          "César Chaussinand";
declare license         "MIT";
declare copyright       "(c) César Chaussinand 2022";

import("stdfaust.lib");

process =   (os.sawtooth(80+gro*120)*gro) +
            (no.noise*(0.9*gro+0.1)) :
                fi.resonlp(gro*500+100,5,gro*0.5) : fx * gate : ef.cubicnl(0.2,0);

fx = _<: _*(1-ring)+_*os.osc(44)*ring;
mod = no.noise:ba.latch(ba.pulse(7000/(rand+1)))*rand*0.1;

gro = hslider("grognement[acc: 0 0 -9 0 9]",0.3, 0,1,0.01)+mod:si.smoo;
ring = hslider("modulation en anneaux[acc:1 0 -9 0 0]",0.5,0,1,0.01);
gate = button("gate[switch:1]"):en.asr(0.01,1,0.01);
rand = hslider("random modulation[knob:2]",0.5,0,1,0.01);
