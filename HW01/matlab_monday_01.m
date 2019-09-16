%% Matlab Monday 01
% September 17, 2018
%% (1) Create an imaging phantom
%%
clear all; close all; clc;
P = phantom('Modified Shepp-Logan',300);
figure(1)
imagesc(P); colormap gray; axis image; axis off;
[sy, sx] = size(P);
title('Shepp-Logan Phantom','FontSize',20);
res_x = .25; % resolution in the x-dir
res_y = .25; % resolution in the y-dir
%% (2) Creating a back-pronection
% (2a) Lets first grab the line profile! 
%%
line_profile = sum(P); % The sum command sums up all of elements in each column

plot((1:sx)*res_x,line_profile,'LineWidth',1.5); axis square
xlabel('Position (mm)','FontSize',20)
ylabel('Sum of Intensity','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)
%% 
% (2b) Let's do a backprojection! 
%%
bp = repmat(line_profile,[sy,1]);
recon = bp;  % the reconstructed image = the backprojection
imagesc([1 sx]*res_x,[1 sy]*res_y,bp);axis square; colormap gray
xlabel('Position (mm)','FontSize',20)
ylabel('Position (mm)','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)
title('Backprojection','FontSize',20)
%% 
% (2c) Okay, on profile is not enough to tell what this is.  So we need 
% to rotate the CT arm and collect a different profile.
%%
% imrotate rotates the image 'P' by a specified angle
angle = 45;
P_rot = imrotate(P,angle,'bilinear','crop');

subplot(1,2,1)
imagesc(P); axis square; axis off;
title('Phantom','FontSize',20)
subplot(1,2,2)
imagesc(P_rot); axis square; axis off; colormap(gray)
title('Rotated Phantom','FontSize',20)
%%
% lets look a the line profile here
figure
line_profile = sum(P_rot);
plot((1:sx)*res_x,line_profile,'LineWidth',1.5); axis square
xlabel('Position (mm)','FontSize',20)
ylabel('Sum of Intensity','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)
%%
% now we need to calculate the back projection
% rotated back projection
bp_rot = repmat(line_profile,[sy,1]);  

% no we have to reverse the rotation of the backprojection
bp = imrotate(bp,-angle,'bilinear','crop');

% add the current bp to "reconstructed" image
recon = recon+bp;
imagesc(recon)
axis image; axis off; colormap jet
title('Backprojection with 2 profiles','FontSize',15)
%%
% okay, 2 angles is not enough lets repeat this  with 180
% angles
recon = zeros(sy,sx);
clear line_profile
num_angles = 180;
angles = 0:(180/(num_angles-1)):180;
for j = 1:180
    P_rot = imrotate(P,angles(j),'bilinear','crop');
    line_profile(j,:) = sum(P_rot);
    bp_rot = repmat(line_profile(j,:),[sy,1]);
    bp = imrotate(bp_rot,-angles(j),'bilinear','crop');
    recon = recon+bp;
end
subplot(1,2,1)
imagesc([1 sx]*res_x,[1 sy]*res_y,recon); colormap(gray)
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

%% 
% (3) Filtered backprojection
%%

figure
filter_allpass = ones(sx,1);  % #nofilter
subplot(2,2,1)
plot(filter_allpass)
axis([0 300 0 1]); axis square
title('All pass')

filter_low = zeros(sx,1); filter_low([(sx/2)-2:(sx/2)+2]) = 1;
subplot(2,2,2)
plot(filter_low)
axis([0 300 0 1]); axis square
title('low pass filter')

filter_high = ones(sx,1); filter_high([(sx/2)-2:(sx/2)+2]) = 0;
subplot(2,2,3)
plot(filter_high)
axis([0 300 0 1]); axis square
title('high pass filter')

filter_ram_lak = ones(sx,1);
for x = 1:(sx/2)
    filter_ram_lak(x) = (sx/2)-x+1;
    filter_ram_lak(sx-x+1) = (sx/2)-x+1;
end
filter_ram_lak = filter_ram_lak;
subplot(2,2,4)
plot(filter_ram_lak/max(filter_ram_lak))
    axis([0 300 0 1]); axis square
    title('ram lak/ramp filter')

    
%%
    figure
    filter = filter_allpass;
    [sy sx] = size(P);
    recon = zeros(sy,sx);
        clear line_profile_filter
        for a = 1:180
            line_profile_filter(a,:) =abs(ifft(fftshift(fft(line_profile(a,:))).*filter'));
                bp_rot = repmat(line_profile_filter(a,:),[sy,1]);
            bp = imrotate(bp_rot,-angles(a),'bilinear','crop');
            recon = recon+bp;
        end
        subplot(2,3,1)
    imagesc((recon)); axis image; axis off;
    title('all pass filter')
    
%%
    
        filter = filter_low;
    recon = zeros(sy,sx);
        clear line_profile_filter
        for a = 1:180
            line_profile_filter(a,:) =abs(ifft(fftshift(fft(line_profile(a,:))).*filter'));
                bp_rot = repmat(line_profile_filter(a,:),[sy,1]);
            bp = imrotate(bp_rot,-angles(a),'bilinear','crop');
            recon = recon+bp;
        end
        subplot(2,3,2)
    imagesc((recon)); axis image; axis off;
    title('low pass filter')
    
%%
        filter = filter_high;
    recon = zeros(sy,sx);
        clear line_profile_filter
        for a = 1:180
            line_profile_filter(a,:) =abs(ifft(fftshift(fft(line_profile(a,:))).*filter'));
                bp_rot = repmat(line_profile_filter(a,:),[sy,1]);
            bp = imrotate(bp_rot,-angles(a),'bilinear','crop');
            recon = recon+bp;
        end
        subplot(2,3,3)
    imagesc((recon)); axis image; axis off;
    title('high pass filter')
%%
        filter = filter_ram_lak;
    recon = zeros(sy,sx);
        clear line_profile_filter
        for a = 1:180
            line_profile_filter(a,:) =abs(ifft(fftshift(fft(line_profile(a,:))).*filter'));
                bp_rot = repmat(line_profile_filter(a,:),[sy,1]);
            bp = imrotate(bp_rot,-angles(a),'bilinear','crop');
            recon = recon+bp;
        end
        subplot(2,3,4)
    imagesc((recon)); axis image; axis off;
    title('ram lak filter')

%%
% Alternative.... iradon




subplot(2,3,5)
p_recon = iradon(permute(line_profile,[2 1]),angles(2)-angles(1),300,'linear');
imagesc(p_recon); axis image; axis off;
title('iradon')