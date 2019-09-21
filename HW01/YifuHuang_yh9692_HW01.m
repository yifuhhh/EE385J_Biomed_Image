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

line_profile_1 = sum(P1);
plot((1:sx1)*res1_x,line_profile_1,'LineWidth',1.5); axis square
xlabel('Position (mm)','FontSize',20)
ylabel('Sum of Intensity','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)

%% Backprojection

bp = repmat(line_profile_1,[sy1,1]);
recon = bp;
imagesc([1 sx1]*res1_x,[1 sy1]*res1_y,recon); axis square; colormap gray
xlabel('Position (mm)','FontSize',20)
ylabel('Position (mm)','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)
title('Backprojection','FontSize',20)

%% Unfiltered backprojection

[recon_3, line_profile_3] = UnfilteredBP(P1, 3);
[recon_10, line_profile_10] = UnfilteredBP(P1, 10);
[recon_30, line_profile_30] = UnfilteredBP(P1, 30);
[recon_180, line_profile_180] = UnfilteredBP(P1, 180);

subplot(2,2,1)
imagesc([1 sx1]*res1_x,[1 sy1]*res1_y,recon_3); colormap(gray)
axis image;
xlabel('Position (mm)','FontSize',20)
title('BP with 3 projections','FontSize',20)
ylabel('Position (mm)','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)

subplot(2,2,2)
imagesc([1 sx1]*res1_x,[1 sy1]*res1_y,recon_10); colormap(gray)
axis image;
xlabel('Position (mm)','FontSize',20)
title('BP with 10 projections','FontSize',20)
ylabel('Position (mm)','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)

subplot(2,2,3)
imagesc([1 sx1]*res1_x,[1 sy1]*res1_y,recon_30); colormap(gray)
axis image;
xlabel('Position (mm)','FontSize',20)
title('BP with 30 projections','FontSize',20)
ylabel('Position (mm)','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)

subplot(2,2,4)
imagesc([1 sx1]*res1_x,[1 sy1]*res1_y,recon_180); colormap(gray)
axis image;
xlabel('Position (mm)','FontSize',20)
title('BP with 180 projections','FontSize',20)
ylabel('Position (mm)','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)

% subplot(1,2,2)
% imagesc(line_profile_1); axis image;
% xlabel('Position (mm)','FontSize',20)
% ylabel('Degrees','FontSize',20)
% set(gca,'FontSize',15,'LineWidth',2)
% title('Sinogram','FontSize',20)

%% Filtered backprojection
angle = 180;

[recon_all, recon_low, recon_high, recon_ram] = FilteredBP(P1, angle, line_profile_180);

subplot(2,2,1)
imagesc((recon_all)); axis image; axis off;
title('All pass filter')

subplot(2,2,2)
imagesc((recon_low)); axis image; axis off;
title('Low pass filter')

subplot(2,2,3)
imagesc((recon_high)); axis image; axis off;
title('High pass filter')

subplot(2,2,4)
imagesc((recon_ram)); axis image; axis off;
title('Ram-lak pass filter')

%% Calculate line profiles and then reconstruct image_02.

% imagesc(P2);

figure

angle = 3;
num_angles = angle;
angles = 0:(180/(num_angles-1)):180;
line_profile_3 = radon(P2, angles);
recon_3 = iradon(permute(line_profile_3,[2 1]), angles(2)-angles(1),sy2,'linear');

angle = 90;
num_angles = angle;
angles = 0:(180/(num_angles-1)):180;
line_profile_90 = radon(P2, angles);
recon_90 = iradon(permute(line_profile_90,[2 1]), angles(2)-angles(1),sy2,'linear');

angle = 180;
num_angles = angle;
angles = 0:(180/(num_angles-1)):180;
line_profile_180 = radon(P2, angles);
recon_180 = iradon(permute(line_profile_180,[2 1]), angles(2)-angles(1),sy2,'linear');

angle = 270;
num_angles = angle;
angles = 0:(180/(num_angles-1)):180;
line_profile_270 = radon(P2, angles);
recon_270 = iradon(permute(line_profile_270,[2 1]), angles(2)-angles(1),sy2,'linear');

angle = 1000;
num_angles = angle;
angles = 0:(180/(num_angles-1)):180;
line_profile_1000 = radon(P2, angles);
recon_1000 = iradon(permute(line_profile_1000,[2 1]), angles(2)-angles(1),sy2,'linear');

subplot(2,3,1)
imagesc([1 sx2]*res2_x,[1 sy2]*res2_y,recon_3); axis image; axis off;
title('3 evenly spaced')

subplot(2,3,2)
imagesc([1 sx2]*res2_x,[1 sy2]*res2_y,recon_90); axis image; axis off;
title('90 evenly spaced')

subplot(2,3,3)
imagesc([1 sx2]*res2_x,[1 sy2]*res2_y,recon_180); axis image; axis off;
title('180 evenly spaced')

subplot(2,3,4)
imagesc([1 sx2]*res2_x,[1 sy2]*res2_y,recon_270); axis image; axis off;
title('270 evenly spaced')

subplot(2,3,5)
imagesc([1 sx2]*res2_x,[1 sy2]*res2_y,recon_1000); axis image; axis off;
title('1000 evenly spaced')

% subplot(1,3,2)
% imagesc([1 sx2]*res2_x,[1 sy2]*res2_y,line_profile_P2); axis image; axis off;
% title('Line profile using iradon')
% 
% subplot(1,3,3)
% imagesc(P2);