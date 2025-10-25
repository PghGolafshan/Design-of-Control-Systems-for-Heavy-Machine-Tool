order = 2; % Second-order filter
cutoff_frequency = 60/(2*pi); % Cutoff frequency in Hz

% Design the Butterworth lowpass filter (analog)
[b, a] = butter(order, cutoff_frequency, 's');

% Create the transfer function
H = tf(b, a);

% Display the transfer function
disp('Transfer function of the 2nd-order lowpass filter in s-domain:');
H

