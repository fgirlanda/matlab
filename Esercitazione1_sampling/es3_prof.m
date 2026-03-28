%% Esercizio: Analisi del Chirp e Aliasing (Senza Fourier)
clear; clc; close all;

%% 1. Caricamento e Analisi Preliminare

%% Generazione del segnale Chirp
%% chirp(t, f0, t_finale, f1, 'linear');
% audiowrite('chirp_signal.wav', chirp(0:1/44100:2, 0, 2, 20000), 44100);

[y, fs] = audioread('chirp_signal.wav');
durata = length(y) / fs;
t = (0:length(y)-1) / fs;

figure, plot(t(1:2205),y(1:2205))   % plot del segnale in [0 0.05s]

fprintf('Frequenza di Campionamento Originale (fs): %d Hz\n', fs);
fprintf('Durata del segnale: %.2f secondi\n', durata);

%% 2. Sottocampionamento (Decimazione)
% Scegliamo un fattore di decimazione N
N = 8; 
y_down = y(1:N:end);       % Prendiamo un campione ogni N (Aliasing)
fs_new = fs / N;           % Nuova frequenza di campionamento
t_new = (0:length(y_down)-1) / fs_new;

fprintf('Nuova Frequenza di Campionamento (fs_new): %d Hz\n', fs_new);
fprintf('Frequenza di Nyquist del nuovo segnale: %d Hz\n', fs_new / 2);

%% 3. Analisi della Forma d'Onda (Zoom Temporale)
% Confrontiamo l'inizio (frequenza bassa) e la fine (frequenza alta)
figure('Name', 'Analisi Temporale Aliasing');

% Segmento Iniziale (Bassa Frequenza)
subplot(2,1,1);
hold on;
plot(t, y, 'b', 'DisplayName', 'Originale');
stem(t_new, y_down, 'r', 'MarkerSize', 4, 'DisplayName', 'Campionato (Down)');
title('Inizio del Chirp: Il campionamento segue la curva');
xlim([0.1, 0.102]); % Zoom su un piccolo intervallo iniziale
xlabel('Tempo (s)'); ylabel('Ampiezza');
legend;
% Segmento Finale (Alta Frequenza - Aliasing)
subplot(2,1,2);
hold on;
plot(t, y, 'b', 'DisplayName', 'Originale');
plot(t_new, y_down, 'r-o', 'MarkerSize', 4, 'DisplayName', 'Campionato (Down)');
title('Fine del Chirp: Campionamento insufficiente (Aliasing)');
xlim([durata-0.002, durata]); % Zoom sulla parte finale ad alta frequenza
xlabel('Tempo (s)'); ylabel('Ampiezza');
legend;
% Nota come nel secondo grafico i punti rossi (campionati) non riescano più 
% a seguire l'oscillazione blu veloce. Unendo i punti rossi, emerge un'onda 
% "falsa" a frequenza molto più bassa: questo è l'Aliasing.
%% 4. Test di Ascolto
fprintf('\nRiproduzione segnale ORIGINALE...');
sound(y, fs);
pause(durata + 1);

fprintf('\nRiproduzione segnale con ALIASING...');
sound(y_down, fs_new);

% L'inversione di tendenza: nel file originale il suono sale e basta. 
% Nel file decimato, notare che a un certo un punto il suono smette di salire 
% e sembra tornare verso il basso. 
% Il limite di Nyquist identifica il momento in cui il suono "cambia direzione".      
% Il suono continuerà a rimbalzare tra 0 Hz e la nuova frequenza di Nyquist del 
% segnale sottocampionato (fNyquist​=fnew​/2), creando un effetto "fisarmonica" sonoro.