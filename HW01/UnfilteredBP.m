function [recon, line_profile] = UnfilteredBP(image, angle)

[sy sx] = size(image);
recon = zeros(sy,sx);
clear line_profile
num_angles = angle;
angles = 0:(180/(num_angles-1)):angle;
for j = 1:angle
    P_rot = imrotate(image,angles(j),'bilinear','crop');
    line_profile(j,:) = sum(P_rot);
    bp_rot = repmat(line_profile(j,:),[sy,1]);
    bp = imrotate(bp_rot,-angles(j),'bilinear','crop');
    recon = recon+bp;
end

end