s.makeWindow;
(
~ptch= (
(
SynthDef.new(\dc,
	{
		arg freq=440, amp = 0.3, gate = 0, bend=0, lef = 20;
		var saw,sqr, env, sin, env2, env3;
		//saw = PinkNoise.kr(0.01,0)!2;
		sqr = Pulse.ar((freq*bend.midiratio), 0.5, amp)!2;
		env = EnvGen.kr(Env.adsr, gate, doneAction:2);
		sin = SinOsc.kr(7);
		env2 = EnvGen.kr(Env.cutoff, gate, doneAction:2);

		sqr = env*sqr*env2*sin;
		Out.ar(0, sqr)
}).add;
)
)
)

~ptch;

(

{

	var in, amp, freq, hasFreq, out;

	in = Mix.ar(SoundIn.ar([0,1]));

	amp = Amplitude.kr(in, mul: 0.4);

	# freq, hasFreq = Pitch.kr(in);

	freq.postln;

	out = Mix.ar( LFSaw.ar(freq) ) * amp;

	6.do({

		out = AllpassN.ar(out, 0.040, [0.040.rand,0.040.rand], 2)

	});

	out

}.play

)



(

// use input amplitude to control Pulse amplitude - use headphones to prevent feedback.

{

	Pulse.ar(90, 0.3, Amplitude.kr(SoundIn.ar(0)))

}.play

)