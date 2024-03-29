%% Learning the Kalman Filter in Simulink Examples 
% Examples to use the Simulink model kalmanfilter.

%% Overview
% The Simulink model shows an example how the Kalman Filter can be
% implemented in Simulink. The model itself is configured with a Gaussian
% process connected with a Kalman Filter. To directly use this model, one
% only needs to provide model prarameters including parameters of the
% Gaussian process, which are state space matrices, A, B, C, and D, initial
% state, x0, and covariance matrices, Q and R; and similar parameters for
% the Kalman Filter, which can be in different values to mimic the model
% mismatch, plus the state covariance, P. The following examples show how
% this model can be used.
%
% The Kalman Filter can also be used as a standard model block to be
% connected with any other systems.



%%  A 2-input 2-output 4-state system with non-zero D
clear all, 
close all, 
dt = 0.1;
randn('seed',11); 


F = [0.8110   -0.0348    0.0499    0.3313
     0.0038    0.8412    0.0184    0.0399
     0.1094    0.4094    0.6319    0.1080
    -0.3186   -0.0254   -0.1446    0.8391];
G = [-0.0130    0.0024
     -0.0011    0.0100
     -0.0781    0.0009
      0.092    0.0138];
H = [0.1685   -0.9595   -0.0755   -0.3771
     0.6664    -0.0835    0.6260    -0.6609];  
 
 
C = randn(1,4);
D = randn(1,2);
% process noise variance
Q=diag([0.8^2 0.5^2]);
% measurement noise variance
R= .1*eye(2);
% initial state
x0 = 4*randn(4,1);
% Kalman filter set up
% The same model
p = 0.1;
F1 = F + 0*randn(size(F));
G1 = G + 0*randn(size(G));
H1 = H + 0*randn(size(H));
Q1 = Q;
R1 = R;
D1 = D + 0*randn(size(D));
C1 = C + 1*randn(size(C));

% However, zeros initial state
%x1 = zeros(4,1); 
x1 = x0;    
% Initial state covariance
P1 = 0.*eye(4,4);

% Simulation set up
% time span 100 samples
tspan = [0 400];
% random input change every 100 samples


u = [(0:400)' randn(401,2)];

%u(50:80, 2:3) = u(50:80, 2:3)+1.5;  

% simulation
[t,x,y1,y2,y3,y4] = sim('kalmanfilter',tspan,[],u);

t = t*dt;
figure
set(gcf,'Position',[100 100 600 800])
for k=1:4
    subplot(4,1,k)
    hold on
    plot(t,y1(:,k),'-bo','markersize',2); % GT
    plot(t,y3(:,k),'-ro','markersize',2); % pred
    legend('Actual state','Kalman prediction')
    title(sprintf('state %i',k))
    hold off
end

xlabel('time, s')


figure
set(gcf,'Position',[100 100 600 800])
for k=1:2
    subplot(2,1,k)
    hold on
    plot(t,y2(:,k),'-bo','markersize',2); % GT
    plot(t,y4(:,k),'-ro','markersize',2); % pred
    legend('Actual state','Kalman prediction')
    title(sprintf('state %i',k))
    hold off
end

disp("done")




