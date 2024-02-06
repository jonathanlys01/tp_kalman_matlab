clear all, 
close all, 

randn('seed',11); 

N = 500;
sigma_n = 0.5;

H = randn(N,4);
theta = randn(4, 1);
theta_AP = zeros(4,1);
M_AP = eye(4);
W = randn(N, 1) .* sigma_n;
x = H*theta + W;

% generate inputs
x_input = [(0:N-1)' x];
h_input = [(0:N-1)' H];

%for simulation
DT = 1.0;
tspan = [0 N-1];
out = sim('llmse',tspan,[],x_input, h_input);

th_est = out.yout{1}.Values.Data;

figure
plot(th_est-theta')
title("Bias for the 4 coordinates");
xlabel("time")
ylabel("bias")
grid on
saveas(gcf,"figs/llmse_bias.png")

figure
MSE = sum((th_est-theta').^2,2);
plot(MSE(1:100,1))
title("MSE (first 100 data points)")
grid on
saveas(gcf,"figs/llmse_mse.png")

