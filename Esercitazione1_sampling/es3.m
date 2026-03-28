% ESTRAZIONE INFORMAZIONI SEGNALE
info = audioinfo('chirp_signal.wav');

disp(info);

fprintf("Informazioni estratte: \n");
fs_info = info.SampleRate;
durata = info.Duration;
n_campioni = info.TotalSamples;



[x, fs] = audioread("chirp_signal.wav");

t = (0:length(x)-1)/fs;

fprintf("Frequenza di campionamento: %d \nDurata: %d \nN: %d \tCampioni con length: %d", fs_info, durata, n_campioni, length(x));

%% SOTTOCAMPIONAMENTO MANUALE - DECIMAZIONE

N = 8;

x_dec = x(1:N:end);

fs_new = fs/N;

t_new = (0:length(x_dec)-1)/fs_new;

%sound(x_dec, fs_new);

%% ANALISI ONDA - ZOOM TEMPORALE

duarata_segm = 0.01;


n_segm = round(fs * duarata_segm);

%% SEGNALE INIZIO
start1 = 1;
end1 = start1 + n_segm - 1;

% Originale
segment1 = x(start1:end1);
t1 = t(start1:end1);

% Decimazione manuale
segment1_dec = segment1(1:N:end);
t1_dec = t1(1:N:end);

%% SEGNALE FINE
start2 = length(x) - n_segm + 1;
end2 = length(x);

% Originale
segment2 = x(start2:end2);
t2 = t(start2:end2);

% Decimazione manuale
segment2_dec = segment2(1:N:end);
t2_dec = t2(1:N:end);

%% GRAFICO  
figure;
sgtitle('Segmenti')

subplot(2, 2, 1);
plot(t1, segment1);
title('Segmento iniziale originale');
xlabel('t (s)');
ylabel('A');

subplot(2, 2, 2);
plot(t1_dec, segment1_dec);
title('Segmento iniziale decimato');
xlabel('t (s)');
ylabel('A');

subplot(2, 2, 3);
plot(t2, segment2);
title('Segmento finale originale');
xlabel('t (s)');
ylabel('A');

subplot(2, 2, 4);
plot(t2_dec, segment2_dec);
title('Segmento finale decimato');
xlabel('t (s)');
ylabel('A');