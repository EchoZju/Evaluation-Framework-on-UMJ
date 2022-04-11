clc
clear
audioPath = ".\JammedAudio.wav";
savePath = ".\NF.wav";

wlen = 4096;
hop = wlen/8;
nfft = 4*wlen;
synth_win = hamming(wlen, 'periodic');
anal_win = blackmanharris(wlen, 'periodic');

[rawdata, fs] = audioread(audioPath);
[S0,F0,T0] = mystft(rawdata, synth_win, hop, nfft, fs);
S1 = S0;
S2 = S0;
protectF = 100;
voiceP = find(abs(F0-protectF) <= min(abs(F0-protectF)));
for i = 1:length(T0)
    Fdata = S1(:,i);
    Fmean = mean(abs(Fdata)); 
    Fmedian = median(abs(Fdata)); 
    Fthreshold = mean([Fmean, Fmedian]);
    maxP = find(abs(Fdata) >= max(abs(Fdata)));
    largeP = find(abs(Fdata) >= Fmedian); 
    for j = voiceP:length(largeP)
        Fdata(largeP(j)) = Fdata(largeP(j))*Fmedian/abs(Fdata(largeP(j)));
    end
    S2(:,i) = Fdata;
end
[x_istft, ~] = myistft(S2, anal_win, synth_win, hop, nfft, fs);
x_istft = x_istft/max(abs(x_istft));
audiowrite(savePath,x_istft,fs)