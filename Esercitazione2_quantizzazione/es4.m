A = 1; f = 50;

b2 = 2; b4 = 4;

L2 = 2^b2; L4 = 2^b4;

delta2 = 2/(L2 -1); % (x_max - x_min)/(L - 1)

delta4 = 2/(L4 - 1);

% Quanti livelli di quantizzazione disponibili?

fprintf("%d bit > %d livelli disponibili\n", b2, L2);
fprintf("%d bit > %d livelli disponibili\n", b4, L4);
fprintf("delta2 > %f\n", delta2);
fprintf("delta4 > %f", delta4);

% Generazione segnale

fs = 1000;
durata = 0.1;
t = (0:1/fs:durata);

x_o = A*sin(2*pi*f*t);

figure;
subplot(2, 1, 1);
plot(t, x_o);
xlabel('Time (s)');
ylabel('Amplitude');
hold on;

% Quantizzazione

[x_q2, errore, delta] = quantizza_segnale(x_o, b2, -A, A);

subplot(2, 1, 2);
plot(t, x_q2);
title('Quantized Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Errore

fprintf("\nSegnale errore > %f", errore);
mse = mean(errore.^2);
fprintf("\nMSE > %f", mse);

fprintf("\n\nAumentando la risoluzione di un bit mi aspetto che il rapporto segnale rumore aumenti di 6.02 dB\n\nQuesto perchè SQNR ~ 6.02*n + 1.76 dB\nDove n = numero di bit.")
