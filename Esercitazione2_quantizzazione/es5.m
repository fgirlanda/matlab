% Estrazione canale sx

[y, fs] = audioread("gong.wav");

canale_sx = y(:, 1);

canale_norm = canale_sx / max(abs(canale_sx));

% Quantizzazione

[canale_q8, errore8, delta8] = quantizza_segnale(canale_norm, 8, -1, 1);
[canale_q4, errore4, delta4] = quantizza_segnale(canale_norm, 4, -1, 1);
[canale_q2, errore2, delta2] = quantizza_segnale(canale_norm, 2, -1, 1);

% Esercizio 6

rumore = delta4 * randn(size(canale_norm));
canale_rum = canale_norm + rumore;
[crum_q, errore_r, delta_r] = quantizza_segnale(canale_rum, 4, -1, 1);


% Test ascolto
pausa = 7;

% sound(canale_norm, fs);
% pause(pausa);

% sound(canale_q8, fs);
% pause(pausa);

sound(canale_q4, fs);
pause(pausa);

% sound(canale_q2, fs);
% pause(pausa);

% sound(rumore, fs);
% pause(pausa);

% sound(canale_rum, fs);
% pause(pausa);

sound(crum_q, fs);





