%% Matlab Monday 5
% Due Monday December 2rd 
%% RECIST!  
%% (Response evaluation criteria in solid tumors)
% Step 1: Identifiy all target lesions
% 
% Step 2: Calculate longest dimension
% 
% Step 3: Compare to pre-treatment measures
% 
% 
% 
% *Complete Response:* Disappearance of all target lesions
% 
% *Partial Response:* at least 30% decrease in longest dimension
% 
% *Stable Disease:* Neither Partial Response nor Progressive disease
% 
% *Progressive Disease:* at least 20% increase in longest dimension
%% *Skeleton Code*
% (1) Visualize all of the tumor slices, and identify which slices you suspect 
% have a tumor

clear all; close all; clc;
load Patient1.mat
data = Patient_T1.enhance;
[sy, sx, sz] = size(data);
for z = 1:sz
    subplot(2,5,z)
    imagesc(data(:,:,z),[0 1.2]); axis image; axis off; colormap gray
end
%% 
% (2) Place ROIs in each of those slices

mask = zeros(sy,sx,sz);
for z  = 5
    imagesc(data(:,:,z),[0 1.5]);
    mask(:,:,z) = roipoly();
end
%% 
% (3) Display ROIs over relevant tumor slices (Matlab Monday 00)
%% RECIST Function
% (4) Use find command to find all x,y indices within tumor (don't forget about 
% the image dimensions, and the position of the slice in the z-direction)

for z = 5
    [x,y] = find(mask(:,:,z));
    tumor_arr = [x y];
end
%% 
% (5) Loop through all voxels, calculate distance between each voxel.  
% 
% (6) Find the longest distance

    npoints = size(tumor_arr,1);
    for i  = 1:npoints  % select one voxel,
        for j  = 1:npoints % loop through all the other voxels, calculate distance
            dx  = 0;
            dy = 0;
            dz = 0;
            dist(j) = 0;  % store distance for each voxel
        end
        dist_list(i) = 0; % store maximum distance for voxel "i"
    end
    
    % longest_dimension = max(dist_list(:));
%% 
% (7) Calculate criteria (above)