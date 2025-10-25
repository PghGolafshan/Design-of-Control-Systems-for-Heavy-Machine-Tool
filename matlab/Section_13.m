clc

% Define the plant transfer function
numerator = [200];
denominator = [0.0001,0.011,0.2,10,40];
G_plant = tf(numerator, denominator);

% Define the PID controller transfer function
K_p = 0.0552;
K_i = 0.348;
C_PID_O = pid(K_p,K_i);

Closed_L = (C_PID_O*G_plant)/(1+C_PID_O*G_plant);
info = stepinfo(Closed_L);

rise_time = info.RiseTime;
T_sample = 0.1*rise_time;

% ZOH Approx
s=tf('s');
G_zoh = 1/(1+0.5*T_sample*s);
Plant_N = G_zoh*G_plant;

% Tunung With PID Tuner
K_p_N = 0.1122;
K_i_N = 0.51;
C_PID_N = pid(K_p_N,K_i_N);

% Discretesation
C_d = c2d(C_PID_N,T_sample,'tustin')
Plant_d = c2d(G_zoh*G_plant,T_sample,'tustin');
Closed_L2 = feedback(Plant_d*C_d,1);

figure;
step(Closed_L)
hold on
step(Closed_L2)
legend('Analog','Digital')