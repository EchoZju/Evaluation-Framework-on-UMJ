# -*- coding: utf-8 -*-

import qualityMeasures as qm
import intelligibilityMeasures as im
import numpy as np
import csv
import os
from scipy.io import wavfile

refPath = "refAudio.wav"
degPath = "degAudio.wav"
sr, ref = wavfile.read(refPath)
sf, deg = wavfile.read(degPath)

# SNR
snr = qm.SNRtest(ref, deg, sr)
segmental_snr = qm.SNRseg(ref, deg, sr)
fwSNR = qm.fwSNRseg(ref, deg, sr)
# Intelligibility
pesq_mos, mos_lqo = qm.pesq(ref, deg, sr)
llr = qm.llr(ref, deg, sr)
stoi = im.stoi(ref,deg,sr)
wss = qm.wss(ref, deg, sr)
ncm = im.ncm(ref, deg, sr)
CSII = im.mi3(ref, deg, sr)