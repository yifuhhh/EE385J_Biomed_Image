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

% Slice 6 @ T1
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

% Slice 7 @ T1
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
% Save the masks to .mat file. Here, Patient1_Tumor_Masks(:, :, 1:3) is
% masks for Slices 5~7 @ T1. Patient1_Tumor_Masks(:, :, 4:6) is
% masks for Slices 5~7 @ T2.
Patient1_Tumor_Masks = zeros(sy, sx, 6);
Patient1_Tumor_Masks(:, :, 1 : 3) = mask_1(:, :, 5 : 7);
Patient1_Tumor_Masks(:, :, 4 : 6) = mask_2(:, :, 5 : 7);
save Patient1_Tumor_Masks.mat Patient1_Tumor_Masks;

%% Calculate the longest dimension
