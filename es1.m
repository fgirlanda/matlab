A = 1; fr = 100; fs = 150; 
fal = abs(fs - fr);
durata = 0.1; dt = 0.0001;

t = 0:dt:durata; % Time vector

signal = A * sin(2 * pi * fr * t); % Generate the signal



