clc
%clear
close all

% Define the plant transfer function
numerator = [200];
denominator = [0.0001,0.011,0.2,10,40];
G_plant = tf(numerator, denominator);

% Define the PID controller transfer function
G_pid = C_pid;
% Closed-loop transfer function
sys_cl = feedback(G_pid * G_plant, 1);


% Unit step response
figure;
impulse(sys_cl);
title('Unit Impulse Response');
grid on;


% Unit step response
figure;
step(sys_cl);
title('Unit Step Response');
grid on;

% Sinusoidal input response
t = 0:0.01:10; % time vector
u = sin(t); % sinusoidal input
[y, t_out] = lsim(sys_cl, u, t);
figure;
plot(t_out, u, '--', t_out, y, 'LineWidth', 1.5);
title('Sinusoidal Input and Output Response');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Input (sin(t))', 'Output Response');
grid on;
