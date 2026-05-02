% CARICAMENTO SEGNALE

load("gsr_signal.mat");


fs = 4; %frequenza di campionamento tipica wearable
t = (0:length(gsr)-1)/fs;

% FILTRI

% filtro passa-basso 1 Hz
fc1 = 1;
[b1, a1] = butter(2, fc1/(fs/2), "low");
gsr_clean = filtfilt(b1, a1, gsr);

% filtro passa-basso 0.05 Hz - componente tonica (scl)

fc2 = 0.05;
[b2, a2] = butter(2, fc2/(fs/2), 'low');
scl = filtfilt(b2, a2, gsr_clean);

% componente fasica (scr): clean - scl

scr = gsr_clean - scl;


% VISUALIZZAZIONE

figure; 

% completo
subplot(4, 2, 1); hold on;
plot(t, gsr, 'LineWidth', 3);
plot(t, gsr_clean, 'r', 'LineWidth', 2);
plot(t, scl, 'g', 'LineWidth', 1);
legend({'Original', 'Low-pass 1hz', 'Low-pass 0.05hz'});
title("Insieme");

% originale
subplot(4, 2, 3);
plot(t, gsr);
title("Originale");

% filtro 1Hz
subplot(4, 2, 5);
plot(t, gsr_clean, 'r');
title("Filtro 1Hz");

% filtro 0.05 Hz - componente tonica

subplot(4, 2, 4);
plot(t, scl, 'g');
title("Componente tonica");

% tonica + clean

subplot(4, 2, 7); hold on;
plot(t, scl, 'g');
plot(t, gsr_clean, 'r');
title("SCL + Clean")
legend({'SCL (tonica)', 'Clean (1 Hz)'});

subplot(4, 2, 6);
plot(t, scr);
title("Componente fasica");