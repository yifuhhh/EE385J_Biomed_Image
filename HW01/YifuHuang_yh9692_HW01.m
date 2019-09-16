clear all;
close all;
clc;

load matlab_monday_01.mat;

P1 = image_01.im;
P2 = image_02.im;

[sy1, sx1] = size(P1);  % image size, P1
[sy2, sx2] = size(P2);  % image size, P2
res1_x = 2; % image resolution x, P1
res1_y = 2; % image resolution y, P1
res2_x = 0.25; % image resolution x, P2
res2_y = 0.25; % image resolution y, P2

%% Line profile of image_01.

line_profile = sum(P1);
plot((1:sx1)*res1_x,line_profile,'LineWidth',1.5); axis square
xlabel('Position (mm)','FontSize',20)
ylabel('Sum of Intensity','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)

%% Backprojection

bp = repmat(line_profile,[sy1,1]);
recon = bp;
imagesc([1 sx1]*res1_x,[1 sy1]*res1_y,bp);axis square; colormap gray
xlabel('Position (mm)','FontSize',20)
ylabel('Position (mm)','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)
title('Backprojection','FontSize',20)

%% Unfiltered backprojection

angle = 180;

[recon, line_profile] = UnfilteredBP(P1, angle);

subplot(1,2,1)
imagesc([1 sx1]*res1_x,[1 sy1]*res1_y,recon); colormap(gray)
axis image;
xlabel(['Position (mm)'],'FontSize',20)
title('Backprojection with 180 projections','FontSize',20)
ylabel('Position (mm)','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)

subplot(1,2,2)
imagesc(line_profile); axis image;
xlabel('Position (mm)','FontSize',20)
ylabel('Degrees','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)
title('Sinogram','FontSize',20)

%% Filtered backprojection

[recon_all, recon_low, recon_high, recon_ram] = FilteredBP(P1, angle, line_profile);

subplot(2,3,1)
imagesc((recon_all)); axis image; axis off;
title('All pass filter')

subplot(2,3,2)
imagesc((recon_low)); axis image; axis off;
title('Low pass filter')

subplot(2,3,3)
imagesc((recon_high)); axis image; axis off;
title('High pass filter')

subplot(2,3,4)
imagesc((recon_ram)); axis image; axis off;
title('Ram-lak pass filter')

%% Using radon and iradon to process P2.

figure

num_angles = angle;
angles = 0:(180/(num_angles-1)):angle;
line_profile_2 = radon(P2, angle);
recon_2 = iradon(permute(line_profile_2,[2 1]),angles(2)-angles(1),sy2,'linear');

subplot(1,2,1)
imagesc([1 sx2]*res2_x,[1 sy2]*res2_y,recon_2); axis image; axis off;
title('Recon using iradon')

subplot(1,2,2)
imagesc([1 sx2]*res2_x,[1 sy2]*res2_y,line_profile_2); axis image; axis off;
title('Line profile using iradon')