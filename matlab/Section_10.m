% Define the plant transfer function
numerator = [200];
denominator = [0.0001,0.011,0.2,10,40];
G_plant = tf(numerator, denominator);

s = tf('s');

% Range of omega_0 values
omega_0_values = [1, 5, 10, 20];

rise_times = zeros(length(omega_0_values), 1);
settling_times = zeros(length(omega_0_values), 1);
overshoots = zeros(length(omega_0_values), 1);

% Loop over omega_0 values
for i = 1:length(omega_0_values)
    omega_0 = omega_0_values(i);

    T = (omega_0^4)/((s+omega_0)^4);
    S = 1-T;
    C_s = T/(G_plant*S);
    Closed_L = feedback(C_s*G_plant,1);
    info = stepinfo(Closed_L);

    % Store the results
    rise_times(i) = info.RiseTime;
    settling_times(i) = info.SettlingTime;
    overshoots(i) = info.Overshoot;
end

% Create a table to display the results
results_table = table(omega_0_values', rise_times, settling_times, overshoots, ...
    'VariableNames', {'Omega_0', 'RiseTime', 'SettlingTime', 'Overshoot'});

% Display the table
disp(results_table);
