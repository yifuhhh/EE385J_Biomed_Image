function maxdist = solvedist(z, mask)
    [x, y] = find(mask == 1);
    tumor_arr = [x, y];
    npoints = size(tumor_arr);
    
    for i = 1:npoints % select one voxel,
        for j = 1 : npoints % loop through all the other voxels, calculate distance
            dx = x(i) - x(j);
            dy = y(i) - y(j);
            dist(j) = sqrt(dx^2 + dy^2);  % store distance for each voxel
        end
        maxdist = max(dist); % store maximum distance for voxel "i"
    end
end