% Define the plant transfer function
numerator = [200];
denominator = [0.0001,0.011,0.2,10,40];
G_plant = tf(numerator, denominator);

% Define the PID controller transfer function
K_p = 0.0552;
K_i = 0.348;
C_PID = pid(K_p,K_i)

Open_L = G_plant*C_PID;
S_tf = 1/(1+Open_L);
figure;
margin(S_tf)
title('Bode PLot Of Sensitivity Transfer Function')
grid on

T_tf = Open_L/(1+Open_L);
figure;
margin(T_tf)
title('Bode PLot Of Complementary Sensitivity Transfer Function')
grid on