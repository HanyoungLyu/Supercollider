(
SynthDef(\Ambient, { |gate=1|
	var lfo, tone, env, flt, del, verb, pan, out;

	lfo  = SinOsc.kr(0.1).range(0.2, 0.8);
	tone = Saw.ar(200 * SinOsc.kr(0.05).range(0.5, 2)) * lfo;

	// sustaining envelope
	env  = Env.asr(0.01, 1, 4);
	tone = tone * EnvGen.kr(env, gate, doneAction:2);

	flt  = RLPF.ar(tone, MouseX.kr(100,5000,1), MouseY.kr(0.05,0.9,1));
	del  = CombC.ar(flt, 0.6, 0.3, 4);
	verb = FreeVerb.ar(del, 0.4, 0.8);
	pan  = LFNoise2.kr(0.1);
	out  = Pan2.ar(verb, pan, 0.3);

	Out.ar(0, out);
}).add;
)

b = Buffer.read(s, thisProcess.nowExecutingPath.dirname ++ "/Choir_A.wav");


(
SynthDef("ChoirLayer", { |buf=0, rate=1|
	var ch, flt, del, verb, out;
	ch  = PlayBuf.ar(2, buf, BufRateScale.kr(buf) * rate, loop:1);

	flt = RLPF.ar(ch, MouseX.kr(200, 4000, 1), MouseY.kr(0.1, 0.9, 1));
	del = CombC.ar(flt, 0.6, 0.35, 4);
	verb= FreeVerb2.ar(del[0], del[1], 0.45, 0.8, 0.25);

	out = Pan2.ar(verb, LFNoise2.kr(0.08), 0.25);

	Out.ar(0, out);
}).add;
)


x = Synth("Ambient");
y = Synth("ChoirLayer", [\buf, b, \rate, 1.0]);

x.free; y.free;
