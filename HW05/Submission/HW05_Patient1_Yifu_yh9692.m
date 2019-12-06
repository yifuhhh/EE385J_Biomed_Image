%% This is the code for Patient 1.

%% Initialize
clear all; close all; clc;
load Patient1.mat
data_1 = Patient_T1.enhance;
data_2 = Patient_T2.enhance;
[sy, sx, sz] = size(data_1);
for z = 1 : sz
    subplot(2, 5, z)
    imagesc(data_1(:, :, z), [0 1.5]); axis image; colormap gray
end

% From the plot we can tell that Slice 5, 6 and 7 have tumor.

%% Place ROIs and show them in Slice 5, 6 and 7.
mask_1 = zeros(sy, sx, sz);
mask_2 = zeros(sy, sx, sz);

%%
% Slice 5 @ T1
imagesc(data_1(:, :, 5), [0 1.5]); axis image; colormap gray
[mask_1(:, :, 5), tumor_x5_T1, tumor_y5_T1] = roipoly();
close all

figure(1)
imagesc(data_1(:, :, 5), [0 1.5]); axis image; colormap gray
title('ROI in Slice 5 @ T1','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x5_T1, tumor_y5_T1, 'r', 'LineWidth', 3)
hold off
saveas(1, 'Figure1-1', 'png');

% Slice 6 @ T1
imagesc(data_1(:, :, 6), [0 1.5]); axis image; colormap gray
[mask_1(:, :, 6), tumor_x6_T1, tumor_y6_T1] = roipoly();
close all

figure(2)
imagesc(data_1(:, :, 6), [0 1.5]); axis image; colormap gray
title('ROI in Slice 6 @ T1','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x6_T1, tumor_y6_T1, 'r', 'LineWidth', 3)
hold off
saveas(2, 'Figure2-1', 'png');

% Slice 7 @ T1
imagesc(data_1(:, :, 7), [0 1.5]); axis image; colormap gray
[mask_1(:, :, 7), tumor_x7_T1, tumor_y7_T1] = roipoly();
close all

figure(3)
imagesc(data_1(:, :, 7), [0 1.5]); axis image; colormap gray
title('ROI in Slice 7 @ T1','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x7_T1, tumor_y7_T1, 'r', 'LineWidth', 3)
hold off
saveas(3, 'Figure3-1', 'png');

%%
% Slice 5 @ T2
imagesc(data_2(:, :, 5), [0 1.5]); axis image; colormap gray
[mask_2(:, :, 5), tumor_x5_T2, tumor_y5_T2] = roipoly();
close all

figure(4)
imagesc(data_2(:, :, 5), [0 1.5]); axis image; colormap gray
title('ROI in Slice 5 @ T2','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x5_T2, tumor_y5_T2, 'r', 'LineWidth', 3)
hold off
saveas(4, 'Figure1-2', 'png');

% Slice 6 @ T2
imagesc(data_2(:, :, 6), [0 1.5]); axis image; colormap gray
[mask_2(:, :, 6), tumor_x6_T2, tumor_y6_T2] = roipoly();
close all

figure(5)
imagesc(data_2(:, :, 6), [0 1.5]); axis image; colormap gray
title('ROI in Slice 6 @ T2','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x6_T2, tumor_y6_T2, 'r', 'LineWidth', 3)
hold off
saveas(5, 'Figure2-2', 'png');

% Slice 7 @ T2
imagesc(data_2(:, :, 7), [0 1.5]); axis image; colormap gray
[mask_2(:, :, 7), tumor_x7_T2, tumor_y7_T2] = roipoly();
close all

figure(6)
imagesc(data_2(:, :, 7), [0 1.5]); axis image; colormap gray
title('ROI in Slice 7 @ T2','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x7_T2, tumor_y7_T2, 'r', 'LineWidth', 3)
hold off
saveas(6, 'Figure3-2', 'png');

%%
% Save the masks to .mat file. 

save Patient1_Tumor_Masks_T1.mat mask_1;
save Patient1_Tumor_Masks_T2.mat mask_2;

%% Calculate the longest dimension
clear all;
load Patient1.mat
load Patient1_Tumor_Masks_T1.mat
load Patient1_Tumor_Masks_T2.mat

% Solve the maximum distance in 3D matrix
maxdist_T1 = solvedist(mask_1);
maxdist_T2 = solvedist(mask_2);

d_dist = ((maxdist_T2 - maxdist_T1)/maxdist_T1)*100;

if d_dist == -100
	disp('Result = CR')
elseif (d_dist > -100 && d_dist <= -30)
	disp('Result = PR')
elseif (d_dist >= 20)
	disp('Result = PD')
else
	disp('Result = SD')
end
