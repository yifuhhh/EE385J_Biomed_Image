%% Matlab Monday 03 inclass
%cb: dah 
%co October 2019

%% Resizing images
clear all; close all; clc;
load US_data

% 
post_small = imresize(post,.7);
% .                    (1) (2)
%(1) Image you want to resize
%(2) What fraction do you want to resize the image by?

post_large = imresize(post,1.5);

figure(1)
subplot(1,3,1)
imagesc(post); axis image; title('Original','FontSize',20)
subplot(1,3,2)
imagesc(post_small); axis image;  title('Downsized','FontSize',20)
subplot(1,3,3)
imagesc(post_large); axis image; title('Upscaled','FontSize',20)

%% Voxel-wise dynamics
figure(2)
imagesc(post);
mask = roipoly();

%%
figure(2)
subplot(1,2,1)
y = 271;
x = 138;
imagesc(post); axis image; axis off;
hold on
plot(x,y,'.w','MarkerSize',20)
hold off
subplot(1,2,2)
plot(t,squeeze(bmdata(y,x,:)),'-.','MarkerSize',15);
xlabel('Time','FontSize',20)
ylabel('Signal Intensity','FontSize',20)
axis square;

%% Okay...thats a little noisy
clc
figure(2)
subplot(1,2,1)
y = 250:250+20;
x = 138:138+20;
imagesc(post); axis image; axis off;
hold on
plot(x,y,'.w','MarkerSize',20)
hold off
subplot(1,2,2)
data = squeeze(mean(mean(bmdata(y,x,:),1),2));
plot(t,data,'-.','MarkerSize',15);
xlabel('Time','FontSize',20)
ylabel('Signal Intensity','FontSize',20)
axis square;


%% LSQcurvefit
%{ 
This function is very similar to lsqnonlin with one major difference.
Instead of creating a function that calculates the residual (that
lsqnonlin minimizes).  You instead create a function that returns the model
estimate, and then lsqcurvefit calculates the residual
%}

time = -10:.01:10;
p = [.5 .1 .05 .7];

truth = poly3model(p,time).*(random('Normal',1,0.2,[length(time) 1]))';
plot(time,truth)

%%
p_guess = [.1 .1 .1 .1]; LB = [0 0 0 0]; UB = [2 2 2 2];
[params] = lsqcurvefit('poly3model',[p_guess],time,truth,LB,UB);
%                                (1) .        (2)     (3)  (4)  (5) (6)
model = poly3model(params,time);
plot(time, truth, '.', 'color', 'k');
hold on
plot(time, model, 'linewidth', 3, 'color', 'r');
hold off
%(1) Model function
%(2) parameter guess
%(3) time vector
%(4) truth vector
%(5+6) Lower and Upper bounds

