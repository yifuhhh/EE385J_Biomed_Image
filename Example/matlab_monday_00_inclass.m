%% Basic Matlab functions
% (1)  Basic Matlab functions
% David Hormuth 
%%
% clear variavles using
clear all; close all; clc;

% Display results using
disp(['Hello: ' num2str(rand)])

% Row array
row = [1 2 3 4]

% column array
column = [1; 2; 3; 4;]

% 2D array 
arr = [1 2 3; 4 5 6; 7 8 9;];
% visualize the matrix in the command line

%%  (2) Visualize the matrix in imagesc
%%
% sets the aspect ratio for the image to match the ratio of the rows to columns 
imagesc(arr,[0 9])

% title  for figure
title('My title','FontSize',20)

% label for horizontal axis
xlabel('Columns','FontSize',20)

% label for vertical axis
ylabel('Rows','FontSize',20)

% increase the font size of the axis 
set(gca,'FontSize',15)

% add colorbar, and add label
axis image
h = colorbar;
ylabel(h,'Values')




%% (3) Manipulating, grabing elements within an array
%%
%     The arrays are index (row,column) versus (column, row) i.e., (x,y)
%     To grab x = 2, y = 3;  we call
arr(1,2)


% To grab one whole row and multiply it by 5 (for some reason)
%      This grabs row 1 and multiplies it by 5
arr(1,:) = 5*arr(1,:)


%% (4) Creating an of evenly spaced numbers
%%
%      create an array spaced by 0.25
time_array = [0:.25:5];


% Now lets only display every 5th one
disp(time_array(1:5:end))

%% (5) Simple plot commands
%%
% create function
f = @(t) t.^2;
measure = f(time_array)+rand([1 length(time_array)])

% plot the function
plot(time_array,f(time_array))


%% (6) Lets make this plot prettier (and make it look like we were fitting something)
%%
plot(time_array,f(time_array),'-k',time_array,...
    measure,'r')
title(' plot','FontSize',20)
xlabel('Time (minutes)','FontSize',20)
ylabel('Signal Intensity','FontSize',20)
axis square 
legend('Model','Measure')
set(gca,'FontSize',20)


% What else should we do to make this figure look nice?
%% (7) For loops, if statements etc...
%%
 % finds the size of arr
arr = [1 2 3; 4 5 6; 7 8 9];
[sy, sx] = size(arr)


% initializes an array full of zeros the same size as arr

arr_out = zeros(sy,sx);

% for loop through arr
for j = 1:length(arr(:))  % loops through each position in arr
    if arr(j) > 4  % if a is greater than 4  set to zero
        arr_out(j) = 0;
    else  % else set it to 1
        arr_out(j) = 1;

    end
end

% display a_out
arr_out

%% 
% (8) Looping through an array
%%
% using a for loop to loop through an array
% 

b_out = zeros(sy,sx);  
for x = 1:sx  % looping through elements in the x-dir
    for y = 1:sy % looping through elements in the y-dir
        b_out(y,x) = arr(y,x)*x;
    end
end
imagesc(b_out)
%% (9) A faster way would be to do this...
%%
% Logic within imagesc

imagesc(arr.*(arr>4))

%% (10) Find and logic 
%%
b =arr
b(b==4) = rand

[min_val min_pos] = min(b(:))
b(min_pos) = 10


%% MRI images
% Now, lets load in some example MRI images and practice some basic image processing 
% routines
% 
% (11) Loading images
%%
clear all; close all; clc
% load matlab dataset

load matlab_monday_00.mat

%% 
% (12) Display images

% assign resolution and matrix size
[sy,sx,sz] = size(image_01.im);
res_x = .3203; % resolution in the x-direction is 0.15625 mm
res_y = .3203; % resolution in the y-direction is 0.15625 mm;
res_z = .1562; % resolution in the z direction is 1 mm;

imagesc(image_01.im(:, :, 100))
%% 
% (13) What is the field of view?


%%
% calculate the field of view
fov_x = res_x*sx;
fov_y = res_y*sy;
fov_z = res_z*sz;
disp(['x-dir: ' num2str(fov_x) ' mm.'])  
disp(['y-dir: ' num2str(fov_y) ' mm.'])  
disp(['z-dir: ' num2str(fov_z) ' mm.'])  


%% 
% (14) What are things we can change on this to make it look better?
%%
% displaying voxels with right aspect ratio

imagesc([1:sy]*res_y,[1:sx]*res_x,mri_rat(:,:,10))
axis image;
colormap(gray)
title('T2 weighted MRI','FontSize',20)
ylabel('Position (mm)','FontSize',20)
xlabel('Position (mm)','FontSize',20)
set(gca,'FontSize',15)

%% 



% labels



%% 
% (15) Can we visualize a different slice orientation?

% * squeeze command! 
imagesc([1:sz]*res_z,[1:sx]*res_x,squeeze(mri_rat(100,:,:))) 
axis image ;
colormap(gray)
title('T2 weighted MRI','FontSize',20)
ylabel('Position (mm)','FontSize',20)
xlabel('Position (mm)','FontSize',20)
set(gca,'FontSize',15)


%% 
% (16) Can we visualize more slices at once?/ what can we do to make this 
% look better?
%%
% Subplot/for loops
for z = 1:3
    subplot(2,2,z)
    imagesc([1:sy]*res_y,[1:sx]*res_x,mri_rat(:,:,z));
    drawnow  
end
%% 
% (17) How can we place ROIs and then display the ROIs?
%%
close all
imagesc(mri_rat(:,:,10))
axis image;
colormap(gray)
title('T2 weighted MRI','FontSize',20)
ylabel('Position (mm)','FontSize',20)
xlabel('Position (mm)','FontSize',20)
set(gca,'FontSize',15)



% place roi around brain
title('Draw ROI around brain','FontSize',20)
[brain_mask, brain_x, brain_y] = roipoly();

% place roi around  muscle
title('Draw ROI around muscle','FontSize',20)
[muscle_mask, muscle_x, muscle_y] = roipoly();

%%


% display rois
close all
imagesc(mri_rat(:,:,10))
axis image;
colormap(gray)
hold on 
plot(brain_x,brain_y,'r','LineWidth',2)
hold on
plot(muscle_x,muscle_y,'y','LineWidth',2)
hold off;


%% 
% (18) Statistics on this image
%%
slice_data = mri_rat(:,:,10);

% Calculate mean & 95% confidence interval (CI)  for brain
mean_brain = mean(slice_data(brain_mask(:)==1))
sd_brain = std(slice_data(brain_mask(:)==1))
ci_brain = 1.96*sd_brain/sqrt(sum(brain_mask(:)))
disp(['Brain SI: ' num2str(mean_brain) ' +/- ' num2str(ci_brain) '.'])

% create histogram of the data
histogram(slice_data(brain_mask(:)==1),'Normalization','pdf')

% Calculate mean & 95% confidence interval (CI)  for muscle
mean_muscle = mean(slice_data(muscle_mask(:)==1))
sd_muscle = std(slice_data(muscle_mask(:)==1))
ci_muscle = 1.96*sd_muscle/sqrt(sum(muscle_mask(:)))
disp(['Muscle SI: ' num2str(mean_muscle) ' +/- ' num2str(ci_muscle) '.'])

% create histogram of the data
histogram(slice_data(muscle_mask(:)==1),'Normalization','pdf')


% or put them on the same histogram
histogram(slice_data(brain_mask(:)==1),'Normalization','pdf')
hold on 
histogram(slice_data(muscle_mask(:)==1),'Normalization','pdf')
hold off

legend('Brain','Muscle','Location','Northoutside','Orientation','horizontal')
%% 
% (19) Calculating SNR and CNR: Place ROI
%%
imagesc(slice_data)
axis image
colormap gray
title('T_2-weighted MRI','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)

% place roi around background
title('Draw ROI around background','FontSize',20)
[background_mask, background_x, background_y] = roipoly();
close all


% display on the image

%% 
% (20) Calculate Statistics
%%
% Calculate mean & 95% confidence interval (CI)  for background
mean_background = mean(slice_data(background_mask(:)==1))
sd_background = std(slice_data(background_mask(:)==1))
ci_background = 1.96*sd_background/sqrt(sum(background_mask(:)==1))
disp(['Background SI: ' num2str(mean_background,3) ' +/- ' num2str(ci_background,3) '.'])

% or put them on the same histogram
histogram(slice_data(brain_mask(:)==1),'Normalization','pdf')
hold on 
histogram(slice_data(muscle_mask(:)==1),'Normalization','pdf')
hold on
histogram(slice_data(background_mask(:)==1),'Normalization','pdf')
hold off

set(gca,'FontSize',18)
hold off
% Calculate SNR for brain to noise 
SNR_brain = mean_brain/sd_background

% Calculate SNR for muscle to noise
SNR_muscle = mean_muscle/sd_background

disp(['SNR: ' num2str(SNR_brain,3) ' (Brain)  ' num2str(SNR_muscle,3) ' (Muscle)'])


% Calculate CNR for brain to muscle
CNR = (mean_brain-mean_muscle)/sd_background


disp(['CNR: ' num2str(CNR,3)])

%%
%%(21) Matrix math
subplot(1,2,1)
imagesc(pre_inj(:,:,10),[0 .7]); axis image; colormap gray
title('Pre-injection','FontSize',20); axis off;

subplot(1,2,2)
imagesc(post_inj(:,:,10),[0 .7]); axis image; colormap gray
title('Post-Injection','FontSize',20); axis off;

%%

% Subtraction
figure
im_diff = post_inj(:,:,10) - pre_inj(:,:,10);
imagesc(im_diff)


% division
im_div = post_inj(:,:,10)./pre_inj(:,:,10);
imagesc(im_div)

% percent difference
figure
im_perdiff = 100*abs(im_diff)./pre_inj(:,:,10);
imagesc(im_perdiff,[0 40]);
%% Voxel-wise math

for y = 1:sy
    for x = 1:sx
        
    end
end



%% (22) Creating Matlab Functions
output = test_function2(pre_inj(:,:,10))