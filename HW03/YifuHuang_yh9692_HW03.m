clear all; close all; clc;
load US_data

%% Q 02

for i = 1 : 199
    imagesc(bmdata(:, :, i)); axis image; axis off;
    drawnow
    pause(0.05);
end

%% Q 03

% Resize

for i = 1 : 199
    bm(:, :, i) = imresize(bmdata(:, :, i), 0.15);
end

% Q 03_a

[sy, sx, sz] = size(bm);

for y = 1 : sy
    for x = 1 : sx
        base_m(y, x) = mean(bm(y, x, 1:5));
        base_s(y, x) = std(bm(y, x, 1:5));
    end
end

figure(1)
subplot(1, 2, 1)
imagesc(base_m); axis image; title('Baseline signal density','FontSize',20);
subplot(1, 2, 2)
imagesc(base_s); axis image; title('Standard deviation','FontSize',20);

% Q 03_b

