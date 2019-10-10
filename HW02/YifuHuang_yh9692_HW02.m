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

figure
imagesc(control_d7.roi_tumor(:,:,83)); axis image; axis off;

% place roi around  tumor
title('Draw ROI around tumor','FontSize',20)
[tumor_mask, tumor_x,tumor_y] = roipoly();
close all

figure
imagesc(control_d7.SUV(:,:,83), [0, 3]); axis image; axis off;

% place roi around muscle
title('Draw ROI around muscle','FontSize',20)
[muscle_mask, muscle_x, muscle_y] = roipoly(); 

close all

% calculate the mean value at each time point
for t = 1:st % loop through each time point
    
    d0 = control_SUV(:,:,83,1);
    d = control_SUV(:,:,83,t);  % d is just a temporary variable;
    
    % mean value of elements within the tumor mask;
    tumor_tc(t,1) = mean(d(tumor_mask(:)))/mean(d0(tumor_mask(:)));
    % 95% confidence interval +/- 1.96*standard_deviation/sqrt(n)
    tumor_tc(t,2) = 1.96*std(d(tumor_mask(:)))/sqrt(sum(tumor_mask(:)));
    
    
    % repeats this for muscle
    muscle_tc(t,1) = mean(d(muscle_mask(:)))/mean(d0(muscle_mask(:)));
    muscle_tc(t,2) = 1.96*std(d(muscle_mask(:)))/sqrt(sum(muscle_mask(:)));

end
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

