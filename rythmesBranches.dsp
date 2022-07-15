declare name            "Rythmes branchés";
declare version         "1.0";
declare author          "César Chaussinand";
declare license         "MIT";
declare copyright       "(c) César Chaussinand 2022";

import("stdfaust.lib");

process =  bell*0.2, (clap*0.6:fx), hihat*0.3, kick*gate :> _ : ef.cubicnl(0,0); 

bell = bEnv*(os.square(800)+os.square(540)) : fi.resonbp(850,4.25,0.1);
bEnv = bTrig:en.ar(0.001,0.2);
bTrig = (clock!=clock')*ba.selectn(16,clock,      0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0 );

kick = kEnv*os.osc(100*kEnv) : ef.cubicnl(0.1,0);
kEnv = kTrig:en.ar(0.001,0.2);
kTrig = (clock!=clock')*ba.selectn(16,clock,      1,0,0,0, 1,0,0,0, 1,0,0,0, 1,0,1,0 );

clap = cEnv * no.noise:fi.resonbp(1000,5,0.8);
cEnv = cTrig:en.ar(0.01,0.1);
cTrig = (clock!=clock')*ba.selectn(16,clock,      0,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,0,1 );
fx = ef.echo(0.11,0.11,fdbk);

hihat = hhEnv*no.noise:fi.resonbp(hhFreq,3,0.8);
hhEnv = hhTrig:en.ar(0.001,0.02);
hhTrig = (clock!=clock')*ba.selectn(16,clock,     1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1 );

clock = os.phasor(16,time):int;

time = hslider("time[knob:2]", 0.5,0.25,0.8,0.01):si.smoo;
hhFreq = hslider("fréquence hihat[acc:1 0 -9 0 9]",7000,2000,15000,1):si.smoo;
gate = checkbox("gate[switch:1]");
fdbk = hslider("feedback de l'écho[acc:0 0 -9 0 0])",0.1,0,0.8,0.01);
