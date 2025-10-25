clc
clear
close all

% Define the numerator and denominator coefficients of the transfer function
numerator = [200];
denominator = [0.0001,0.011,0.24,10.4,0];

% Create the transfer function
sys = tf(numerator, denominator);

% Display the transfer function
disp('The transfer function is:');
disp(sys);

% Simulate and plot the step response
figure;
step(sys);
title('Step Response');
xlabel('Time (seconds)');
ylabel('Response');
grid on;

% Simulate and plot the impulse response
figure;
impulse(sys)
title('Impulse Response');
xlabel('Time (seconds)');
ylabel('Response');
grid on;

% Plot the Bode plot
figure;
bode(sys);
title('Bode Plot');
grid on;

% Plot the pole-zero map
figure;
pzmap(sys);
title('Pole-Zero Map');
grid on;

% Calculate and display the poles and zeros of the system
[p, z] = pzmap(sys);
disp('The poles of the system are:');
disp(p);
disp('The zeros of the system are:');
disp(z);

% Calculate and display the time constants of the system
time_constants = -1 ./ real(p);
disp('The time constants of the system are:');
disp(time_constants);

figure;
rlocus(sys)
grid on

