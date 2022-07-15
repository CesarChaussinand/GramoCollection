declare name            "Mélodie pulsée";
declare version         "1.0";
declare author          "César Chaussinand";
declare license         "MIT";
declare copyright       "(c) César Chaussinand 2022";

import("stdfaust.lib");

process =   osc(219.9),osc(freq):>_*amp:ef.echo(0.2,0.2,0.2) , beat :>
            ef.cubicnl(0.1,0);

osc(f) = os.osc(f)*0.5+os.osc(f*2)*0.25+os.osc(f*3)*0.125;
beat = (no.noise*0.2+os.osc(kickEnv*130+20))*kickEnv*kickVol;
kickEnv = ba.pulse(22050): en.ar(0.01,0.1);

freq = hslider("v:synthétiseur/[1]fréquence[acc:0 0 -10 0 10]",440,220,660,1):qu.quantizeSmoothed(220,qu.kumoi):si.smoo;
amp = button("v:synthétiseur/[0]gate[switch:1]"):en.asr(0.1,1,0.9);
kickVol = hslider("v:kick/[2]volume[knob:2]",0,0,5,0.1);
