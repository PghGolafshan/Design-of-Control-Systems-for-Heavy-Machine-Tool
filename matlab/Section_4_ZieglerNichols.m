clc
clear
close all

% PID Controller
numerator = [200];
denominator = [0.0001,0.011,0.24,10.4,0];
G = tf(numerator, denominator);
[Gm,Pm,Wg,Wp] = margin(G);
Kc = Gm;
Tc = 2*pi/Wg;

% pid controller
Kp = 0.6*Kc;
Ti = 0.5*Tc;
Td = 0.12*Tc;
s=tf('s');
C = Kp*(1 + ((1/Ti)/s) + Td*s)

CL = feedback(C*G,1);
figure;
step(CL)