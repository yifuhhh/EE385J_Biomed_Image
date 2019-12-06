%% This is the code for Patient 2.

%% Initialize
clear all; close all; clc;
load Patient2.mat
data_1 = Patient_T1.enhance;
data_2 = Patient_T2.enhance;
[sy, sx, sz] = size(data_1);
for z = 1 : sz
    subplot(2, 5, z)
    imagesc(data_1(:, :, z), [0 1.2]); axis image; colormap gray
end

% From the plot we can tell that Slice 1 ~ 8 have tumor.

%% Place ROIs and show them in Slice 1 ~ 8.
mask_1 = zeros(sy, sx, sz);
mask_2 = zeros(sy, sx, sz);

%%
% Slice 1 @ T1
imagesc(data_1(:, :, 1), [0 1.2]); axis image; colormap gray
[mask_1(:, :, 1), tumor_x1_T1, tumor_y1_T1] = roipoly();
close all

figure(1)
imagesc(data_1(:, :, 1), [0 1.2]); axis image; colormap gray
title('ROI in Slice 1 @ T1','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x1_T1, tumor_y1_T1, 'r', 'LineWidth', 3)
hold off
saveas(1, 'Figure4-1', 'png');

% Slice 2 @ T1
imagesc(data_1(:, :, 2), [0 1.2]); axis image; colormap gray
[mask_1(:, :, 2), tumor_x2_T1, tumor_y2_T1] = roipoly();
close all

figure(2)
imagesc(data_1(:, :, 2), [0 1.2]); axis image; colormap gray
title('ROI in Slice 2 @ T1','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x2_T1, tumor_y2_T1, 'r', 'LineWidth', 3)
hold off
saveas(2, 'Figure5-1', 'png');

% Slice 3 @ T1
imagesc(data_1(:, :, 3), [0 1.2]); axis image; colormap gray
[mask_1(:, :, 3), tumor_x3_T1, tumor_y3_T1] = roipoly();
close all

figure(3)
imagesc(data_1(:, :, 3), [0 1.2]); axis image; colormap gray
title('ROI in Slice 3 @ T1','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x3_T1, tumor_y3_T1, 'r', 'LineWidth', 3)
hold off
saveas(3, 'Figure6-1', 'png');

% Slice 4 @ T1
imagesc(data_1(:, :, 4), [0 1.2]); axis image; colormap gray
[mask_1(:, :, 4), tumor_x4_T1, tumor_y4_T1] = roipoly();
close all

figure(4)
imagesc(data_1(:, :, 4), [0 1.2]); axis image; colormap gray
title('ROI in Slice 4 @ T1','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x4_T1, tumor_y4_T1, 'r', 'LineWidth', 3)
hold off
saveas(4, 'Figure7-1', 'png');

% Slice 5 @ T1
imagesc(data_1(:, :, 5), [0 1.2]); axis image; colormap gray
[mask_1(:, :, 5), tumor_x5_T1, tumor_y5_T1] = roipoly();
close all

figure(5)
imagesc(data_1(:, :, 5), [0 1.2]); axis image; colormap gray
title('ROI in Slice 5 @ T1','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x5_T1, tumor_y5_T1, 'r', 'LineWidth', 3)
hold off
saveas(5, 'Figure8-1', 'png');

% Slice 6 @ T1
imagesc(data_1(:, :, 6), [0 1.2]); axis image; colormap gray
[mask_1(:, :, 6), tumor_x6_T1, tumor_y6_T1] = roipoly();
close all

figure(6)
imagesc(data_1(:, :, 6), [0 1.2]); axis image; colormap gray
title('ROI in Slice 6 @ T1','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x6_T1, tumor_y6_T1, 'r', 'LineWidth', 3)
hold off
saveas(6, 'Figure9-1', 'png');

% Slice 7 @ T1
imagesc(data_1(:, :, 7), [0 1.2]); axis image; colormap gray
[mask_1(:, :, 7), tumor_x7_T1, tumor_y7_T1] = roipoly();
close all

figure(7)
imagesc(data_1(:, :, 7), [0 1.2]); axis image; colormap gray
title('ROI in Slice 7 @ T1','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x7_T1, tumor_y7_T1, 'r', 'LineWidth', 3)
hold off
saveas(7, 'Figure10-1', 'png');

% Slice 8 @ T1
imagesc(data_1(:, :, 8), [0 1.2]); axis image; colormap gray
[mask_1(:, :, 8), tumor_x8_T1, tumor_y8_T1] = roipoly();
close all

figure(8)
imagesc(data_1(:, :, 8), [0 1.2]); axis image; colormap gray
title('ROI in Slice 8 @ T1','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x8_T1, tumor_y8_T1, 'r', 'LineWidth', 3)
hold off
saveas(8, 'Figure11-1', 'png');

%%
% Slice 1 @ T2
imagesc(data_2(:, :, 1), [0 1.2]); axis image; colormap gray
[mask_2(:, :, 1), tumor_x1_T2, tumor_y1_T2] = roipoly();
close all

figure(9)
imagesc(data_2(:, :, 1), [0 1.2]); axis image; colormap gray
title('ROI in Slice 1 @ T2','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x1_T2, tumor_y1_T2, 'r', 'LineWidth', 3)
hold off
saveas(9, 'Figure4-2', 'png');

% Slice 2 @ T2
imagesc(data_2(:, :, 2), [0 1.2]); axis image; colormap gray
[mask_2(:, :, 2), tumor_x2_T2, tumor_y2_T2] = roipoly();
close all

figure(10)
imagesc(data_2(:, :, 2), [0 1.2]); axis image; colormap gray
title('ROI in Slice 2 @ T2','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x2_T2, tumor_y2_T2, 'r', 'LineWidth', 3)
hold off
saveas(10, 'Figure5-2', 'png');

% Slice 3 @ T2
imagesc(data_2(:, :, 3), [0 1.2]); axis image; colormap gray
[mask_2(:, :, 3), tumor_x3_T2, tumor_y3_T2] = roipoly();
close all

figure(11)
imagesc(data_2(:, :, 3), [0 1.2]); axis image; colormap gray
title('ROI in Slice 3 @ T2','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x3_T2, tumor_y3_T2, 'r', 'LineWidth', 3)
hold off
saveas(11, 'Figure6-2', 'png');

% Slice 4 @ T2
imagesc(data_2(:, :, 4), [0 1.2]); axis image; colormap gray
[mask_2(:, :, 4), tumor_x4_T2, tumor_y4_T2] = roipoly();
close all

figure(12)
imagesc(data_2(:, :, 4), [0 1.2]); axis image; colormap gray
title('ROI in Slice 4 @ T2','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x4_T2, tumor_y4_T2, 'r', 'LineWidth', 3)
hold off
saveas(12, 'Figure7-2', 'png');

% Slice 5 @ T2
imagesc(data_2(:, :, 5), [0 1.2]); axis image; colormap gray
[mask_2(:, :, 5), tumor_x5_T2, tumor_y5_T2] = roipoly();
close all

figure(13)
imagesc(data_2(:, :, 5), [0 1.2]); axis image; colormap gray
title('ROI in Slice 5 @ T2','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x5_T2, tumor_y5_T2, 'r', 'LineWidth', 3)
hold off
saveas(13, 'Figure8-2', 'png');

% Slice 6 @ T2
imagesc(data_2(:, :, 6), [0 1.2]); axis image; colormap gray
[mask_2(:, :, 6), tumor_x6_T2, tumor_y6_T2] = roipoly();
close all

figure(14)
imagesc(data_2(:, :, 6), [0 1.2]); axis image; colormap gray
title('ROI in Slice 6 @ T2','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x6_T2, tumor_y6_T2, 'r', 'LineWidth', 3)
hold off
saveas(14, 'Figure9-2', 'png');

% Slice 7 @ T2
imagesc(data_2(:, :, 7), [0 1.2]); axis image; colormap gray
[mask_2(:, :, 7), tumor_x7_T2, tumor_y7_T2] = roipoly();
close all

figure(15)
imagesc(data_2(:, :, 7), [0 1.2]); axis image; colormap gray
title('ROI in Slice 7 @ T2','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x7_T2, tumor_y7_T2, 'r', 'LineWidth', 3)
hold off
saveas(15, 'Figure10-2', 'png');

% Slice 8 @ T2
imagesc(data_2(:, :, 8), [0 1.2]); axis image; colormap gray
[mask_2(:, :, 8), tumor_x8_T2, tumor_y8_T2] = roipoly();
close all

figure(16)
imagesc(data_2(:, :, 8), [0 1.2]); axis image; colormap gray
title('ROI in Slice 8 @ T2','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x8_T2, tumor_y8_T2, 'r', 'LineWidth', 3)
hold off
saveas(16, 'Figure11-2', 'png');

%%
% Save the masks to .mat file.

save Patient2_Tumor_Masks_T1.mat mask_1;
save Patient2_Tumor_Masks_T2.mat mask_2;

%% Calculate the longest dimension
clear all;
load Patient2.mat
load Patient2_Tumor_Masks_T1.mat
load Patient2_Tumor_Masks_T2.mat

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
