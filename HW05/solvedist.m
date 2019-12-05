function maxdist = solvedist(mask)
    ind = find(mask == 1);
    [x, y, z] = ind2sub(size(mask), ind);
    tumor_arr = [x, y, z];
    npoints = size(tumor_arr);
    
    for i = 1 : npoints % select one voxel,
        for j = 1 : npoints % loop through all the other voxels, calculate distance
            dx = x(i) - x(j);
            dy = y(i) - y(j);
            dz = z(i) - z(j);
            dist(j) = sqrt(dx^2 + dy^2 + (dz * 5)^2);  % store distance for each voxel
        end
        mdist(i) = max(dist); % store maximum distance for voxel "i"
    end
    maxdist = max(mdist);
end