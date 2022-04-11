clc
clear
audioPath = ".\JammedAudio.wav";
noisePath = ".\EavesdroppedNoise.wav";
savePath = ".\ANF.wav";

mu  = 0.1;
a = 0.1;
M = 30;

[rawdata, fs] = audioread(audioPath);
[noisedata, ~] = audioread(noisePath);

x = rawdata;
d = noisedata;
[e2, y2, w2] = myNLMS(d, x, mu, M, a);
writedata = e2/max(abs(e2));
audiowrite(savePath,writedata,fs)