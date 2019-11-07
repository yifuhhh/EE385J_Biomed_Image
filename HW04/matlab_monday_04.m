%% Matlab Monday 04
% November 11, 2019
% 
% (1) K-space example

clear all; close all; clc;
load matlab_monday_04.mat
res_x = 1; % mm
res_y = 1; % mm

[sy,sx] = size(kspace);
kx = (1/(sx/10))*((1:sx)-sx/2);
ky = kx;
imagesc(kx,ky,abs(kspace)); axis image;
xlabel('k_x (cm^-^1)','FontSize',20)
ylabel('k_y (cm^-^1)','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)
title('K-space','FontSize',20)
%% 
% (1.1) Let's take the log of k-space to get a better view of what is happening

imagesc(kx,ky,log10(abs(kspace))); axis image;
xlabel('k_x (cm^-^1)','FontSize',20)
ylabel('k_y (cm^-^1)','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)
title('log(K-space)','FontSize',20)
%% 
% (2) How do we get the image back out of this?

% First take the inverse fourier transform, then take absolute value

image = abs((ifft2(kspace,1000,1000)));
imagesc(image); axis image; colormap gray
xlabel('Position (cm)','FontSize',20)
ylabel('Position (cm)','FontSize',20)
title('T2-w MRI','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)

%% 
% (3) What happens when part of k-space is missing?

kspace2 = kspace;
kspace2(1:(sy/3),:) = 0;
kspace2((2*sy/3):end,:) = 0;
kspace2(:,1:(sx/3)) = 0;
kspace2(:,(2*sx/3):end) = 0;
imagesc(kx,ky,log(abs(kspace2))); axis image;
xlabel('k_x (cm^-^1)','FontSize',20)
ylabel('k_y (cm^-^1)','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)
title('K-space','FontSize',20)

image = abs((ifft2(kspace2)));
imagesc((1:sx)/10,(1:sy)/10,image); axis image; colormap gray
xlabel('Position (cm)','FontSize',20)
ylabel('Position (cm)','FontSize',20)
title('T2-w MRI','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)
%% 
% (4) Gradient Echo Signal Equation

S0 = 1; % maximum signal
S_ge = @(TR,alpha,T1) S0*(sind(alpha)*(1-exp(-TR/T1)))./(1-(cosd(alpha)*exp(-TR/T1)));

TR  = 200; %ms
T1  = [500 1000 1500 2000]; % ms;
alpha = [0:.1:100];
figure(1)
plot(alpha,S_ge(TR,alpha,T1(1)),alpha,S_ge(TR,alpha,T1(2)),alpha,S_ge(TR,alpha,T1(3)),...
    alpha,S_ge(TR,alpha,T1(4)),'LineWidth',2); axis square
xlabel('Flip Angle (deg)','FontSize',20)
ylabel('Signal Intensity','FontSize',20)
set(gca,'FontSize',20,'LineWidth',1.5)
legend(num2str(T1(1)),num2str(T1(2)),num2str(T1(3)),num2str(T1(4)),'Location','northoutside','Orientation','horizontal')
title('Gradient Echo','FontSize',20)

figure(2)
TR  = [1:0.1:2000]; %ms
T1  = [500 1000 1500 2000]; % ms;
alpha = [50];
figure(1)
plot(TR,S_ge(TR,alpha,T1(1)),TR,S_ge(TR,alpha,T1(2)),TR,S_ge(TR,alpha,T1(3)),...
    TR,S_ge(TR,alpha,T1(4)),'LineWidth',2); axis square
xlabel('TR (ms)','FontSize',20)
ylabel('Signal Intensity','FontSize',20)
set(gca,'FontSize',20,'LineWidth',1.5)
title('Gradient Echo','FontSize',20)
legend(num2str(T1(1)),num2str(T1(2)),num2str(T1(3)),num2str(T1(4)),'Location','northoutside','Orientation','horizontal')


%% 
% (5) Spin Echo Signal Equation

S0 = 1; % maximum signal
S_se = @(TR,T1) S0*(1-exp(-TR/T1));


figure(1)
TR  = [1:0.1:10000]; %ms
T1  = [500 1000 1500 2000]; % ms;
figure(1)
plot(TR,S_se(TR,T1(1)),TR,S_se(TR,T1(2)),TR,S_se(TR,T1(3)),...
    TR,S_se(TR,T1(4)),'LineWidth',2); axis square
xlabel('TR (ms)','FontSize',20)
ylabel('Signal Intensity','FontSize',20)
set(gca,'FontSize',20,'LineWidth',1.5)
title('Spin Echo','FontSize',20)
legend(num2str(T1(1)),num2str(T1(2)),num2str(T1(3)),num2str(T1(4)),'Location','northoutside','Orientation','horizontal')
%% 
% LSQcurvefit example

params = [500 2];
options = optimset('TolFun',1e-12,'TolX',1e-12);
options = optimset('Display','off');
options = optimset(options,'MaxIter',150,'MaxFunEval',2000);

xdata = 0:1:90;  % measurement points
TR = 10;
truth = sample_function(params,xdata,TR);  % create data for learning purposes
plot(xdata,truth)  % plot that
%%
params_guess = [200 90];
params_fit = lsqcurvefit('sample_function',params_guess,xdata,truth,[],[],options,TR);


plot(xdata,truth,'.',xdata,sample_function(params_fit,xdata,TR))