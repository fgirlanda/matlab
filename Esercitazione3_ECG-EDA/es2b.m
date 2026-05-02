% risposte fasiche in scr = picchi in scr 

[picchi, posizioni] = findpeaks(scr, 'MinPeakHeight', 0.01, 'MinPeakDistance', fs);

% features

features = struct();
features.mean_SCL = mean(scl); % media scl
features.std_SCL = std(scl); % deviazione standard
features.num_peaks = length(picchi); % numero risposte fasiche
features.mean_peaks = mean(picchi); % media risposte fasiche
features.max_peaks = max(picchi); % massima risposta fasica
features.sum_peaks = sum(picchi); % somma risposte fasiche

disp("Features calcolate:");
disp(features);