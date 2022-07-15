declare name            "Mélodie bruiteuse";
declare version         "1.0";
declare author          "César Chaussinand";
declare license         "MIT";
declare copyright       "(c) César Chaussinand 2022";

import("stdfaust.lib");

process = os.sawtooth(freq*mod)*env:ef.echo(0.2,0.2,fdbk):fi.lowpass3e(6*freq*env+10);

mod = (100+no.noise*bruit)/100;

freq = hslider("fréquence[acc:0 0 -9 0 9]",300,150,600,1):qu.quantize(110,qu.eolian):si.smoo;
bruit = hslider("bruit[acc:1 0 -9 0 9]",30,0,100,1);    //pourcentage de bruit à ajouter
env = button("gate[switch:1]"):en.adsr(0.01,0.1,0.6,0.3);
fdbk = hslider("feedback de l'écho[knob:2]",0.2,0,0.5,0.01);
