%% Initialize
clear;
close all;
clc;

load matlab_monday_02.mat;

control_SUV(:, :, :, 1) = control_d0.SUV;
control_SUV(:, :, :, 2) = control_d1.SUV;
control_SUV(:, :, :, 3) = control_d3.SUV;
control_SUV(:, :, :, 4) = control_d4.SUV;
control_SUV(:, :, :, 5) = control_d7.SUV;

control_tumor(:, :, :, 1) = control_d0.roi_tumor;
control_tumor(:, :, :, 2) = control_d1.roi_tumor;
control_tumor(:, :, :, 3) = control_d3.roi_tumor;
control_tumor(:, :, :, 4) = control_d4.roi_tumor;
control_tumor(:, :, :, 5) = control_d7.roi_tumor;

control_muscle(:, :, :, 1) = control_d0.roi_muscle;
control_muscle(:, :, :, 2) = control_d1.roi_muscle;
control_muscle(:, :, :, 3) = control_d3.roi_muscle;
control_muscle(:, :, :, 4) = control_d4.roi_muscle;
control_muscle(:, :, :, 5) = control_d7.roi_muscle;

treated_SUV(:, :, :, 1) = treated_d0.SUV;
treated_SUV(:, :, :, 2) = treated_d1.SUV;
treated_SUV(:, :, :, 3) = treated_d3.SUV;
treated_SUV(:, :, :, 4) = treated_d4.SUV;
treated_SUV(:, :, :, 5) = treated_d7.SUV;

treated_tumor(:, :, :, 1) = treated_d0.roi_tumor;
treated_tumor(:, :, :, 2) = treated_d1.roi_tumor;
treated_tumor(:, :, :, 3) = treated_d3.roi_tumor;
treated_tumor(:, :, :, 4) = treated_d4.roi_tumor;
treated_tumor(:, :, :, 5) = treated_d7.roi_tumor;

treated_muscle(:, :, :, 1) = treated_d0.roi_muscle;
treated_muscle(:, :, :, 2) = treated_d1.roi_muscle;
treated_muscle(:, :, :, 3) = treated_d3.roi_muscle;
treated_muscle(:, :, :, 4) = treated_d4.roi_muscle;
treated_muscle(:, :, :, 5) = treated_d7.roi_muscle;

time_SUV = [0, 1, 3, 4, 7];

[sx, sy, sz, st] = size(control_SUV);

%% calculate the mean value at each time point
for t = 1:st % loop through each time point
    
    d0_c = control_SUV(:, :, :, 1); % d0_x is the first day value
    d_c = control_SUV(:, :, :, t);  % d_x is a temporary variable;
    d0_t = treated_SUV(:, :, :, 1);
    d_t = treated_SUV(:, :, :, t);
    tumor_mask_c(:, :, :) = control_tumor(:, :, :, t);
    muscle_mask_c(:, :, :) = control_muscle(:, :, :, t);
    tumor_mask_t(:, :, :) = treated_tumor(:, :, :, t);
    muscle_mask_t(:, :, :) = treated_muscle(:, :, :, t);
    tumor_mask0_c(:, :, :) = control_tumor(:, :, :, 1);
    muscle_mask0_c(:, :, :) = control_muscle(:, :, :, 1);
    tumor_mask0_t(:, :, :) = treated_tumor(:, :, :, 1);
    muscle_mask0_t(:, :, :) = treated_muscle(:, :, :, 1);
    
    % mean value of elements within the tumor mask;
    tumor_tc_c(t,1) = mean(d_c(tumor_mask_c(:) == 1));
    % mean value of elements within the tumor mask, normalized;
    tumor_tc_c(t,2) = tumor_tc_c(t,1)/mean(d0_c(tumor_mask0_c(:) == 1));
    % 95% confidence interval +/- 1.96*standard_deviation/sqrt(n)
    tumor_tc_c(t,3) = 1.96*std(d_c(tumor_mask_c(:) == 1))/sqrt(sum(tumor_mask_c(:) == 1));
    
    
    % repeats this for muscle, control;
    muscle_tc_c(t,1) = mean(d_c(muscle_mask_c(:) == 1));
    muscle_tc_c(t,2) = muscle_tc_c(t,1)/mean(d0_c(muscle_mask0_c(:) == 1));
    muscle_tc_c(t,3) = 1.96*std(d_c(muscle_mask_c(:) == 1))/sqrt(sum(muscle_mask_c(:) == 1));

    % repeats this for tumor, treated;
    tumor_tc_t(t,1) = mean(d_t(tumor_mask_t(:) == 1));
    tumor_tc_t(t,2) = tumor_tc_t(t,1)/mean(d0_t(tumor_mask0_t(:) == 1));
    tumor_tc_t(t,3) = 1.96*std(d_t(tumor_mask_t(:) == 1))/sqrt(sum(tumor_mask_t(:) == 1));

    % repeats this for tumor, treated;
    muscle_tc_t(t,1) = mean(d_t(muscle_mask_t(:) == 1));
    muscle_tc_t(t,2) = muscle_tc_t(t,1)/mean(d0_t(muscle_mask0_t(:) == 1));
    muscle_tc_t(t,3) = 1.96*std(d_t(muscle_mask_t(:) == 1))/sqrt(sum(muscle_mask_t(:) == 1));

end

%% Plot the mean values
% Tumor, without normalization
plot(time_SUV,tumor_tc_c(:,1),'-r',time_SUV,tumor_tc_t(:,1),'-b','LineWidth',2)
hold on
errorbar(time_SUV,tumor_tc_c(:,1),tumor_tc_c(:,3),'-r','LineWidth',2);
errorbar(time_SUV,tumor_tc_t(:,1),tumor_tc_t(:,3),'-b','LineWidth',2);
hold off;

xlabel('Time (day)','FontSize',20)
ylabel('Activity','FontSize',20)
title('Signal from one voxel','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)
legend('Control','Treated','Location','Northoutside','Orientation','horizontal')

% Muscle, without normalization
plot(time_SUV,muscle_tc_c(:,1),'-r',time_SUV,muscle_tc_t(:,1),'-b','LineWidth',2)
hold on
errorbar(time_SUV,muscle_tc_c(:,1),muscle_tc_c(:,3),'-r','LineWidth',2);
errorbar(time_SUV,muscle_tc_t(:,1),muscle_tc_t(:,3),'-b','LineWidth',2);
hold off;

xlabel('Time (day)','FontSize',20)
ylabel('Activity','FontSize',20)
title('Signal from one voxel','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)
legend('Control','Treated','Location','Northoutside','Orientation','horizontal')

% Tumor, with normalization
plot(time_SUV,tumor_tc_c(:,2),'-r',time_SUV,tumor_tc_t(:,2),'-b','LineWidth',2)
hold on
errorbar(time_SUV,tumor_tc_c(:,2),tumor_tc_c(:,3),'-r','LineWidth',2);
errorbar(time_SUV,tumor_tc_t(:,2),tumor_tc_t(:,3),'-b','LineWidth',2);
hold off;

xlabel('Time (day)','FontSize',20)
ylabel('Activity','FontSize',20)
title('Signal from one voxel','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)
legend('Control','Treated','Location','Northoutside','Orientation','horizontal')

% Muscle, with normalization
plot(time_SUV,muscle_tc_c(:,2),'-r',time_SUV,muscle_tc_t(:,2),'-b','LineWidth',2)
hold on
errorbar(time_SUV,muscle_tc_c(:,2),muscle_tc_c(:,3),'-r','LineWidth',2);
errorbar(time_SUV,muscle_tc_t(:,2),muscle_tc_t(:,3),'-b','LineWidth',2);
hold off;

xlabel('Time (day)','FontSize',20)
ylabel('Activity','FontSize',20)
title('Signal from one voxel','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)
legend('Control','Treated','Location','Northoutside','Orientation','horizontal')
