function [recon_all, recon_low, recon_high, recon_ram] = FilteredBP(image, angle, line_profile)

[sy, sx] = size(image);
clear line_profile_filter
num_angles = angle - 1;
angles = 0:(180/num_angles):180;

%%
filter_allpass = ones(sx,1);  % #nofilter

filter_low = zeros(sx,1); filter_low([(sx/2)-2:(sx/2)+2]) = 1;

filter_high = ones(sx,1); filter_high([(sx/2)-2:(sx/2)+2]) = 0;

filter_ram_lak = ones(sx,1);
for x = 1:(sx/2)
    filter_ram_lak(x) = (sx/2)-x+1;
    filter_ram_lak(sx-x+1) = (sx/2)-x+1;
end
%filter_ram_lak = filter_ram_lak;

%%
filter = filter_allpass;
recon_all = zeros(sy,sx);
for a = 1:angle
    line_profile_filter(a,:) =abs(ifft(fftshift(fft(line_profile(a,:))).*filter'));
    bp_rot = repmat(line_profile_filter(a,:),[sy,1]);
    bp = imrotate(bp_rot,-angles(a),'bilinear','crop');
    recon_all = recon_all+bp;
end

%%
filter = filter_low;
recon_low = zeros(sy,sx);
% clear line_profile_filter
for a = 1:angle
    line_profile_filter(a,:) =abs(ifft(fftshift(fft(line_profile(a,:))).*filter'));
	bp_rot = repmat(line_profile_filter(a,:),[sy,1]);
	bp = imrotate(bp_rot,-angles(a),'bilinear','crop');
	recon_low = recon_low+bp;
end

%%
filter = filter_high;
recon_high = zeros(sy,sx);
% clear line_profile_filter
for a = 1:angle
	line_profile_filter(a,:) =abs(ifft(fftshift(fft(line_profile(a,:))).*filter'));
	bp_rot = repmat(line_profile_filter(a,:),[sy,1]);
	bp = imrotate(bp_rot,-angles(a),'bilinear','crop');
	recon_high = recon_high+bp;
end

%%
filter = filter_ram_lak;
recon_ram = zeros(sy,sx);
% clear line_profile_filter
for a = 1:angle
    line_profile_filter(a,:) =abs(ifft(fftshift(fft(line_profile(a,:))).*filter'));
    bp_rot = repmat(line_profile_filter(a,:),[sy,1]);
	bp = imrotate(bp_rot,-angles(a),'bilinear','crop');
	recon_ram = recon_ram+bp;
end

end