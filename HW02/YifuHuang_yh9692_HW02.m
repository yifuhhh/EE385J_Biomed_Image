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

treated_SUV(:, :, :, 1) = treated_d0.SUV;
treated_SUV(:, :, :, 2) = treated_d1.SUV;
treated_SUV(:, :, :, 3) = treated_d3.SUV;
treated_SUV(:, :, :, 4) = treated_d4.SUV;
treated_SUV(:, :, :, 5) = treated_d7.SUV;

time = [0, 1, 3, 4, 7]

[sx, sy, sz, st] = size(control_SUV);

%% ROI selection
% place roi around  tumor, control
figure
imagesc(control_d7.roi_tumor(:, :, 83)); axis image; axis off;
title('Draw ROI around tumor','FontSize',20)
[tumor_mask_c, tumor_x_c, tumor_y_c] = roipoly();
close all

% place roi around muscle, control
figure
imagesc(control_d7.SUV(:, :, 83), [0, 3]); axis image; axis off;
title('Draw ROI around muscle','FontSize',20)
[muscle_mask_c, muscle_x_c, muscle_y_c] = roipoly(); 
close all

% place roi around  tumor, treat
figure
imagesc(treated_d0.roi_muscle(:, :, 40)); axis image; axis off;
title('Draw ROI around tumor','FontSize',20)
[tumor_mask_t, tumor_x_t, tumor_y_t] = roipoly();
close all

% place roi around muscle, control
figure
imagesc(treated_d7.SUV(:, :, 83), [0, 3]); axis image; axis off;
title('Draw ROI around muscle','FontSize',20)
[muscle_mask_t, muscle_x_t, muscle_y_t] = roipoly(); 
close all

%% calculate the mean value at each time point
for t = 1:st % loop through each time point
    
    d0 = control_SUV(:, :, 83, 1);
    d = control_SUV(:, :, 83, t);  % d is just a temporary variable;
    
    % mean value of elements within the tumor mask;
    tumor_tc(t,1) = mean(d(tumor_mask_c(:)))/mean(d0(tumor_mask_c(:)));
    % 95% confidence interval +/- 1.96*standard_deviation/sqrt(n)
    tumor_tc(t,2) = 1.96*std(d(tumor_mask_c(:)))/sqrt(sum(tumor_mask_c(:)));
    
    
    % repeats this for muscle
    muscle_tc(t,1) = mean(d(muscle_mask_c(:)))/mean(d0(muscle_mask_c(:)));
    muscle_tc(t,2) = 1.96*std(d(muscle_mask_c(:)))/sqrt(sum(muscle_mask_c(:)));

end

%% Plot the mean values
plot(time,tumor_tc(:,1),'-r',time,muscle_tc(:,1),'-b','LineWidth',2)
hold on
errorbar(time,tumor_tc(:,1),tumor_tc(:,2),'-r','LineWidth',2);
errorbar(time,muscle_tc(:,1),muscle_tc(:,2),'-b','LineWidth',2);
hold off;

xlabel('Time (day)','FontSize',20)
ylabel('Activity','FontSize',20)
title('Signal from one voxel','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)
legend('Tumor','Muscle','Location','Northoutside','Orientation','horizontal')

