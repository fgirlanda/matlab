%  ========= CARICAMENTO SEGNALE ========= 
load("noisyecg.mat");

% segnale "sporcato" (with trend) da movimenti o respirazione del paziente
nECG = noisyECG_withTrend;

t = 1:length(nECG);

%  ========= DETREND SEGNALE ========= 
% segnale ottenuto rimuovendo il trend (sottrae dal segnale la sua approssimazione polinomiale)
detnECG = detrend(nECG, 5); % 5 = ordine dell'approssimazione



%  ========= PICCHI R e FREQUENZA CARDIACA ========= 

%  trova i picchi R nell'ECG
isR = islocalmax(detnECG, 'MinProminence', 0.9); % restituisce un array di 0 (non max) e 1 (max)
ecgPeak = find(isR); % trova le posizioni sull'asse x dei massimi (1 in isR)
disp(ecgPeak);


RRinterval = mean(diff(ecgPeak)); % ms tra un battito e l'altro
fprintf("-------------\nIntervallo medio RR: %d\n-------------\n", RRinterval);

% formula ricostruita
RRintervalS = RRinterval/1000; % ms -> s
heartRateC = 60/RRintervalS; % battiti al minuto = 60 s/min / s/battiti

% formula diretta equivalente
heartRate = 60 * (1000/RRinterval); % 60/(RRinterval/1000) = 60 * 1000/RRinterval

fprintf("Costruita:\nHeart rate = %d bpm\n\nDiretta:\nHeart rate = %d bpm", heartRateC, heartRate);

%  ========= FILTRO PASSABANDA ========= 

fs = 1000; % Sampling frequency in Hz
lowCutoff = 0.5; % Low cutoff frequency in Hz
highCutoff = 25; % High cutoff frequency in Hz
[b, a] = butter(2, [lowCutoff, highCutoff] / (fs / 2), 'bandpass'); % 2nd order Butterworth filter
filteredECG = filtfilt(b, a, nECG);

%  ========= VISUALIZZAZIONE ========= 
figure;
subplot(3, 1, 1);
plot(t, nECG, 'b'); hold on;

plot(t, detnECG, 'r'); hold on;

plot(t, nECG - detnECG, LineWidth=2);

xlabel("ms"), ylabel("mV");
legend({'Original', 'Detrended', 'Trend'});

subplot(3, 1, 2);
plot(t, detnECG); hold on;
plot(t(isR), detnECG(isR), 'rv');


subplot(3, 1, 3);
plot(t, filteredECG);
