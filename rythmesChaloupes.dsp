declare name            "Rythmes chaloupés";
declare version         "1.0";
declare author          "César Chaussinand";
declare license         "MIT";
declare copyright       "(c) César Chaussinand 2022";

import("stdfaust.lib");

process =  bell1*0.2*b1vol, bell2*0.2*b2vol, shaker*0.1*gate, tom1*0.3, tom2*0.3 :> _ : ef.cubicnl(0,0); 

bell1 = env*(os.square(800)+os.square(540)) : fi.resonbp(850,4.25,0.1) with {
    env = trig:en.ar(0.001,0.2);
    trig = (clock!=clock')*ba.selectn(12,clock,      1,0,0, 0,0,0, 0,1,0, 1,0,0 );
};

bell2 = env * (os.square(800*Index)+os.square(540*Index)) : fi.resonbp(850*Index,4.25,0.1) with {
    env = trig:en.ar(0.01,0.1);
    trig = (clock!=clock')*ba.selectn(12,clock,      0,0,0 ,1,0,0, 0,0,0, 0,0,1 );
    Index = 1.5;
};

tom1 = env*os.osc(100+env*50) : ef.cubicnl(0.1,0) with {
    env = trig:en.ar(0.01,0.3);
    trig = (clock!=clock')*ba.selectn(12,clock,      1,0,0, 0,0,1, 1,0,0, 0,0,0 );
};

tom2 = env*os.osc(50+env*50) : ef.cubicnl(0.1,0) with {
    env = trig:en.ar(0.01,0.3);
    trig = (clock!=clock')*ba.selectn(12,clock,      0,0,0, 1,0,0, 0,1,0, 1,0,0 );
};

shaker = env*no.noise:fi.resonbp(7000,2,0.4) with{
    env = trig:en.ar(0.05,0.05);
    trig = (clock!=clock')*ba.selectn(12,clock,     1,1,1, 1,1,1, 1,1,1, 1,1,1 );
};

clock = os.phasor(12,time):int;

time = hslider("time[knob:2]", 0.5,0.3,0.7,0.01):si.smoo;
gate = checkbox("gate[switch:1]");
b1vol = hslider("volume de la cloche n°1[acc:0 0 -9 0 9]",0.1,0,1,0.01);
b2vol = hslider("volume de la cloche n°2[acc:1 0 -9 0 9]",0.1,0,1,0.01);
