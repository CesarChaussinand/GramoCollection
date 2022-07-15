declare name            "Harmonies déréglées";
declare version         "1.0";
declare author          "César Chaussinand";
declare license         "MIT";
declare copyright       "(c) César Chaussinand 2022";

import("stdfaust.lib");

process = par(i,4,os.osc(noteSelector(selAccord,i))+os.osc(noteSelector(selAccord,i)*2)):>_/4:effet*gate:ef.cubicnl(drive,0);

noteSelector(accord,note) =     54,57,61,68, 
                                51,54,59,63,
                                51,56,63,64 :
                                            ba.selectn(12,int(accord*4)+int(note)):ba.midikey2hz;
effet = _*lfo<:_*ringMod*depth,_*(1-depth):>_*(1+depth)/2;
lfo = os.sawtooth(4):fi.lowpass3e(100)*depth+(1-depth);
ringMod = os.osc(depth*200+100);

selAccord = nentry("accord[acc:0 0 -9 0 9]",1,0,2,1);
depth = hslider("lfo[acc:1 0 -9 0 9]",0.5,0,1,0.01);
gate = button("gate[switch:1]"):en.asr(0.2,1,0.2);
drive = hslider("drive[knob:2]",0,-0.2,0.2,0.01);
