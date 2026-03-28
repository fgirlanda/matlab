%function [x_q, errore] = quantizza_segnale(x, delta, L, Vmin, Vmax)
%    x_q = round((x-Vmin)/delta) * delta + Vmin;
%    errore = x - x_q;
%end

function [x_quant, errore, delta] = quantizza_segnale(x, n_bits, Vmin, Vmax)
    % QUANTIZZA_SEGNALE Esegue una quantizzazione uniforme 
    %
    % Input:
    %   x      : Segnale originale
    %   n_bits : Numero di bit di risoluzione
    %   Vmin   : Valore minimo dell'intervallo di quantizzazione
    %   Vmax   : Valore massimo dell'intervallo di quantizzazione
    %
    % Output:
    %   x_quant: Segnale quantizzato
    %   errore : Segnale errore (x - x_quant)
    %   delta  : Ampiezza dello step di quantizzazione

    % Calcolo del numero di livelli e dello step (Delta)
    L = 2^n_bits; 
    delta = (Vmax - Vmin) / (L - 1);

    % Processo di Quantizzazione
    % Trasliamo il segnale per farlo partire da 0
    % La funzione "round((x - Vmin) / delta)" trasforma il valore continuo del
    % segnale in un indice intero (da 0 a L−1).
    % alla fine riportiamo nel range originale
    x_quant = round((x - Vmin) / delta) * delta + Vmin;
    
    % Calcolo del segnale errore
    errore = x - x_quant;
end