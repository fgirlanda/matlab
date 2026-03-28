% --- Parametri ---
f_reale = 100;        % Il segnale originale
fs = 250;       % Frequenza di campionamento 
f_alias = abs(fs - f_reale); % La frequenza di aliasing

% --- 1. La Realtà (Analogica) ---
% Usiamo una fs altissima solo per disegnare la linea curva "vera"
fs_alta = 10000;
t_reale = 0:1/fs_alta:0.1; 
y_reale = sin(2*pi*f_reale*t_reale);
figure, plot(t_reale,y_reale)

%sound(y_reale, fs)

% --- 2. Il Campionamento ---
t_camp = 0:1/fs:0.1;
y_camp = sin(2*pi*f_reale*t_camp); % Campioniamo il segnale da 100Hz
hold on, plot(t_camp,y_camp,'g*')

% --- 3. L'Illusione (L'Alias) ---
% Costruiamo un segnale a 50 Hz per vedere se passa per gli stessi punti.
% Nota: Mettiamo un meno davanti al seno perché l'aliasing a volte inverte la fase!
y_alias = -sin(2*pi*f_alias*t_reale); 
hold on,
plot(t_reale,y_alias)

% --- Grafico ---
figure;
plot(t_reale, y_reale, 'k', 'LineWidth', 1); hold on; % Grigio
plot(t_reale, y_alias, 'b--', 'LineWidth', 2);        % Blu tratteggiato
stem(t_camp, y_camp, 'r', 'filled', 'LineWidth', 1.5);  % Punti Rossi
legend('Segnale Reale', 'Segnale Percepito (Alias)', 'Campioni Presi');
title(['Effetto Aliasing: Campionando a ', num2str(fs), ' Hz']);
xlabel('Tempo (s)'); grid on;



