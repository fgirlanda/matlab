clear all,clc,close all
% Il seguente file viene fornito direttamente da MATLAB.
% Presenta un segnale ECG rumoroso.
load('noisyecg.mat')
nECG = noisyECG_withTrend;
clear noisyECG_withTrend
% Il segnale viene misurato da elettrodi attaccati alla pelle 
% ed è sensibile a disturbi come le interferenze delle 
% sorgenti di alimentazione e i rumori dovuti al movimento.  
% Questo esempio presenta uno spostamento della linea 
% di base 
t = 1:length(nECG);
figure, plot(t, nECG), xlabel('ms'), ylabel('mV')
% Rimuoviamo il trend applicando la funzione detrend
dtECG = detrend(nECG, 5);
figure, hold on
plot(t, nECG, 'b')
plot(t, dtECG, 'r')
plot(t, nECG - dtECG, 'k',LineWidth=2)
hold off

legend({'original ECG', 'detrended ECG', 'trend'})
xlabel('ms'), ylabel('mV')

% calcolo della frequenza cardiaca
% trovare la distanza tra le varie onde R
% cercare i massimi locali.
% trovare la distanza tra questi picchi.

ismax = islocalmax(dtECG, 'MinProminence', 0.9);
ecgPeak = find(ismax);
RRinterval = mean(diff(ecgPeak));
heartRate = 60 * (1000/RRinterval); 
disp(['Frequenza cardiaca: ' num2str(round(heartRate)) ' bpm'])

figure, hold on
plot(t, dtECG)
% Riportiamo i massimi locali
plot(ecgPeak, dtECG(ecgPeak), '^')
title(['R: ' num2str(length(ecgPeak))])
hold off

legend({'detrended EEG', 'R'})
xlabel('ms'), ylabel('mV')

% assumiamo frequenza campionamento = 1000 Hz
% Per fare il denoise si utilizzano comunemente 
% 0.5 Hz – 25 Hz come banda passante per preservare 
% le componenti cardiache utili e ridurre rumori indesiderati.
fs=1000;
f_low=0.5; % Hz
f_high=25; % Hz
[b,a] = butter(2,[f_low,f_high]/(fs/2),'bandpass');
% filtro il segnale nECG originale
filt_ecg=filtfilt(b,a,nECG);
figure, plot(t,filt_ecg,'r',LineWidth=2);
hold on,
plot(t,dtECG,'b')
legend({'filtered ecg', 'detrended EEG'})