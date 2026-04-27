%  ========= PARTE 1 ========= 
load("noisyecg.mat");

% segnale "sporcato" (with trend) da movimenti o respirazione del paziente
nECG = noisyECG_withTrend;

t = 1:length(nECG);

% segnale ottenuto rimuovendo il trend (sottrae dal segnale la sua approssimazione polinomiale)
detnECG = detrend(nECG, 5); % 5 = ordine dell'approssimazione

figure;
subplot(2, 1, 1);
plot(t, nECG, 'b'); hold on;

plot(t, detnECG, 'r'); hold on;

plot(t, nECG - detnECG, LineWidth=2);

xlabel("ms"), ylabel("mV");
legend({'Original', 'Detrended', 'Trend'});

%  ========= PARTE 2 ========= 

%  trova i picchi R nell'ECG
isR = islocalmax(detnECG, 'MinProminence', 0.9); % restituisce un array di 0 (non max) e 1 (max)
ecgPeak = find(isR); % trova le posizioni sull'asse x dei massimi (1 in isR)
disp(ecgPeak);


RRinterval = mean(diff(ecgPeak)); % ms tra un battito e l'altro

% formula ricostruita
RRintervalS = RRinterval/1000; % ms -> s
heartRateC = 60/RRintervalS; % battiti al minuto = 60 s/min / s/battiti

% formula diretta equivalente
heartRate = 60 * (1000/RRinterval); % 60/(RRinterval/1000) = 60 * 1000/RRinterval

fprintf("Costruita:\nHeart rate = %d bpm\n\nDiretta:\nHeart rate = %d bpm", heartRateC, heartRate);

subplot(2, 1, 2);
plot(t, detnECG); hold on;
plot(t(isR), detnECG(isR), 'rv');

