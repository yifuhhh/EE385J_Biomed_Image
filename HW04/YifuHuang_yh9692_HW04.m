%% HW04 begins
%% Initializing
clear all;
close all;
clc;
load matlab_monday_04.mat
res_x = 1; % mm
res_y = 1; % mm

%% Question 1
% Q1 (a)

% Get K-space
[sy,sx] = size(kspace);
kx = (1/(sx/10))*((1:sx)-sx/2);
ky = kx;

% Put every other row in K space as 0;
kspace1 = kspace;
kspace1(1 : 2 : end, :) = 0;
image = abs((ifft2(kspace1)));
figure(1)
imagesc((1:sx)/10, (1:sy)/10, image); axis image; colormap gray
xlabel('Position (cm)', 'FontSize', 20)
ylabel('Position (cm)', 'FontSize', 20)
title('Every other row in k-space is 0','FontSize', 20)
set(gca,'FontSize', 15, 'LineWidth', 2)
saveas(1, 'Figure1', 'png');

% Put every other column as 0;
kspace2 = kspace;
kspace2(:, 1 : 2 : end) = 0;
image = abs((ifft2(kspace2)));
figure(2)
imagesc((1:sx)/10, (1:sy)/10, image); axis image; colormap gray
xlabel('Position (cm)', 'FontSize', 20)
ylabel('Position (cm)', 'FontSize', 20)
title('Every other row & column in k-space is 0', 'FontSize', 20)
set(gca,'FontSize', 15, 'LineWidth', 2)
saveas(2, 'Figure2', 'png');

% Q1 (b) Here we establish a circular filter area with the radius of 40.

x = linspace(-sx/2, sx/2, 240);
y = linspace(-sy/2, sy/2, 240);
[X,Y] = meshgrid(x,y);
lpf = sqrt(X.^2+Y.^2);
for i = 1 : sy
    for j = 1 : sx
        if lpf(i, j) > 40
            lpf(i, j) = 0;
        else
            lpf(i, j) = 1;
        end
    end
end
imagesc((1:sx)/10, (1:sy)/10, lpf); axis image; colormap gray

kspace_l = kspace .* lpf;
figure(3)
imagesc(kx, ky, log10(abs(kspace_l))); axis image;
xlabel('k_x (cm^-^1)', 'FontSize', 20)
ylabel('k_y (cm^-^1)', 'FontSize', 20)
set(gca,'FontSize', 15, 'LineWidth', 2)
title('K-space after low-pass filter', 'FontSize', 20)
saveas(3, 'Figure3', 'png');

image = abs((ifft2(kspace_l)));
figure(4)
imagesc((1:sx)/10, (1:sy)/10, image); axis image; colormap gray
xlabel('Position (cm)', 'FontSize', 20)
ylabel('Position (cm)', 'FontSize', 20)
title('Low pass filtered', 'FontSize', 20)
set(gca,'FontSize', 15, 'LineWidth', 2)
saveas(4, 'Figure4', 'png');

% Q1 (c) The same circular filter area but value inversed.

x = linspace(-sx/2, sx/2, 240);
y = linspace(-sy/2, sy/2, 240);
[X,Y] = meshgrid(x,y);
hpf = sqrt(X.^2+Y.^2);
for i = 1 : sy
    for j = 1 : sx
        if hpf(i, j) > 40
            hpf(i, j) = 1;
        else
            hpf(i, j) = 0;
        end
    end
end
imagesc((1:sx)/10, (1:sy)/10, hpf); axis image; colormap gray

kspace_h = kspace .* hpf;
figure(5)
imagesc(kx, ky, log10(abs(kspace_h))); axis image;
xlabel('k_x (cm^-^1)', 'FontSize', 20)
ylabel('k_y (cm^-^1)', 'FontSize', 20)
set(gca,'FontSize', 15, 'LineWidth', 2)
title('K-space after high-pass filter', 'FontSize', 20)
saveas(5, 'Figure5', 'png');

image = abs((ifft2(kspace_h)));
figure(6)
imagesc((1:sx)/10, (1:sy)/10, image); axis image; colormap gray
xlabel('Position (cm)', 'FontSize', 20)
ylabel('Position (cm)', 'FontSize', 20)
title('High pass filtered', 'FontSize', 20)
set(gca,'FontSize', 15, 'LineWidth', 2)
saveas(6, 'Figure6', 'png');

%% Question 2
close all;
clear all;
clc;
load matlab_monday_04.mat

options = optimset('TolFun',1e-12,'TolX',1e-12);
options = optimset('Display','off');
options = optimset(options,'MaxIter',150,'MaxFunEval',2000);

% TR_s1
params_guess = zeros(2, 13);
for i = 1 : 13
    truth1 = VTR_s1(i, :);
    params_guess = [0.1, 200];
    params_fit(:, i) = lsqcurvefit('HW04_function', params_guess, TR_s1, truth1, [], [], options);
end
Err_1 = sum(((T1-params_fit(2, :)) ./ T1) .^ 2);

refx=[0 3000];
refy=[0 3000];

figure(7)
plot(params_fit(2, :), T1, "o", refx, refy, 'k', 'LineWidth', 1)
axis([0 3000 0 3000])
title("T1 Estimation 1", 'FontSize', 20)
xlabel("Estimated", 'FontSize', 20)
ylabel("Actual", 'FontSize', 20)
set(gca,'FontSize', 15, 'LineWidth', 1)
saveas(7, 'Figure7', 'png');

% TR_s2
params_guess = zeros(2, 13);
for i = 1 : 13
    truth2 = VTR_s2(i, :);
    params_guess = [0.1, 200];
    params_fit(:, i) = lsqcurvefit('HW04_function', params_guess, TR_s2, truth2, [], [], options);
end
Err_2 = sum(((T1-params_fit(2, :)) ./ T1) .^ 2);

refx=[0 3000];
refy=[0 3000];

figure(8)
plot(params_fit(2, :), T1, "o", refx, refy, 'k', 'LineWidth', 1)
axis([0 3000 0 3000])
title("T1 Estimation 2", 'FontSize', 20)
xlabel("Estimated", 'FontSize', 20)
ylabel("Actual", 'FontSize', 20)
set(gca,'FontSize', 15, 'LineWidth', 1)
saveas(8, 'Figure8', 'png');

figure(9)
plot([1:21], TR_s1, 'LineWidth', 1);
hold on
plot([1:21], TR_s2, 'LineWidth', 1);
hold off
title("TR contrast", 'FontSize', 20)
xlabel("Data point", 'FontSize', 20)
ylabel("TR value", 'FontSize', 20)
set(gca,'FontSize', 15, 'LineWidth', 1)
saveas(9, 'Figure9', 'png');