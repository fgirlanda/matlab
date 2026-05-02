clear all,clc,close all
load('gsr_signal.mat')
Fs = 4; % Esempio: segnale da Empatica E4
t = (0:length(gsr)-1)/Fs;

% Filtro Passa-Basso (Pre-processing)
[b1, a1] = butter(2, 1/(Fs/2), 'low');
gsr_clean = filtfilt(b1, a1, gsr);

% Estrazione Tonica (SCL)
[b2, a2] = butter(2, 0.05/(Fs/2), 'low');
scl = filtfilt(b2, a2, gsr_clean);

% Estrazione Fasica (SCR)
scr = gsr_clean - scl;

% calcolo delle features:
% Rilevamento dei picchi (SCR Peaks)
min_height = 0.01; % Soglia minima tipica: 0.01 microSiemens (uS)
[pks, locs] = findpeaks(scr, Fs, 'MinPeakHeight', min_height, 'MinPeakDistance', 1);

%% 4. Calcolo delle Features
features = struct();
features.mean_SCL = mean(scl);             % Livello medio di conduttanza
features.std_SCL = std(scl);               % Variabilità della comp. tonica
features.num_peaks = length(pks);          % Numero di picchi (frequenza SCR)
features.mean_amplitude = mean(pks);       % Ampiezza media delle risposte
features.max_amplitude = max(pks);         % Picco massimo registrato
features.sum_amplitude = sum(pks);         % Intensità totale dello stimolo

% Visualizzazione
subplot(2,1,1), plot(t, gsr_clean, t, scl), title('GSR e Componente Tonica');
subplot(2,1,2), plot(t, scr, 'r');
hold on;
plot(locs, pks, 'ko', 'MarkerFaceColor', 'y');
title('Componente Fasica e picchi rilevati');
xlabel('Tempo (s)'); ylabel('\muS');
grid on;

disp('Features calcolate:');
disp(features);