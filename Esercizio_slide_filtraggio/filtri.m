f = 440;
fs = 44100;
t = 0:1/fs:2;

pulito = sin(2*pi*f*t);

disturbo = 0.5 * sin(2*pi*50*t);
rumore = 0.2 * sin(2*pi*randn*t);

disturbato = pulito + disturbo;
dist_rum = disturbato + rumore;

% FILTRI
fc1 = 150;
[b1, a1] = butter(2, fc1/(fs/2), 'high');
filtrato1 = filtfilt(b1, a1, dist_rum);

fc2 = 3000;
[b2, a2] = butter(2, fc2/(fs/2), 'high');
filtrato2 = filtfilt(b2, a2, filtrato1);

% GRAFICI
subplot(5, 1, 1);
plot(t, pulito);

subplot(5, 1, 2);
plot(t, disturbato);

subplot(5, 1, 3);
plot(t, dist_rum);

subplot(5, 1, 4);
plot(t, filtrato1);

subplot(5, 1, 5);
plot(t, filtrato2);

% SUONO
sound(pulito, fs);
pause(4);
sound(disturbato, fs);
pause(4);
sound(dist_rum, fs);
pause(4);
sound(filtrato1/max(abs(filtrato1)), fs);
pause(4);
sound(filtrato2/max(abs(filtrato2)), fs);