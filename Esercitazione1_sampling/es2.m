% Parametri
f_reale = 440;
fs = 44100;

% Segnale reale
durata = 2;
t_reale = 0:1/fs:durata;
y_reale = sin(2*pi*f_reale*t_reale);
sound(y_reale, fs);
pause(2);

% Frequenza di campionamento modificata
fs_doppia = fs*2;
sound(y_reale, fs_doppia); % durata dimezzata e nota un'ottava + alta



pause(2);
fs_mezza = fs/2;
sound(y_reale, fs_mezza); % durata doppia e suono un'ottava + bassa




