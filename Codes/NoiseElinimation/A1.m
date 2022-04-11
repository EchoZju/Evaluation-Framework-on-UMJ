clc
clear
numSrc = 2;
audioPath = [".\JammedAudio_1.wav",".\JammedAudio_2.wav"];
savePath = [".\BSS_1.wav",".\BSS_2.wav"];

[rawdata1, fs1] = audioread(audioPath(1));
[rawdata2, ~] = audioread(audioPath(2));
srcMat = [rawdata1';rawdata2'];
[~,YY,WW] = noiseICA(srcMat,numSrc,0);
for i = 1:numSrc
    removedAudio = YY(i,:); 
    writedata = removedAudio/max(abs(removedAudio));
    audiowrite(savePath(i),writedata2,fs1)
end