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

figure(2)
imagesc(bm(:, :, 100));
[tumor_mask, tumor_x, tumor_y] = roipoly();
close all

imagesc(bm(:,:,100)); axis image; axis off;
axis image
colormap parula
title('Segment the tumor tissue','FontSize',20)
xlabel('Position (mm)','FontSize',15)
ylabel('Position (mm)','FontSize',15)
set(gca,'FontSize',15)
hold on
plot(tumor_x, tumor_y, 'r', 'LineWidth', 2)
hold off

% Q 03_c

max_tumor = zeros(75, 70);
for y = 1 : sy
    for x = 1 : sx
        if tumor_mask(y, x) == 1
            max_tumor(y, x) = (max(bm(y, x, :)))/(base_m(y, x));
        else
            max_tumor(y, x) = 100;
        end
    end
end

figure(3)
imagesc(max_tumor, [1, 1.3]); axis image; axis off;
axis image
colormap hot
colorbar

% Q 03_d

bd_tumor = zeros(75, 70, 4);
for i = 1 : 4
    for y = 1 : sy
        for x = 1 : sx
            if tumor_mask(y, x) == 1
                bd_tumor(y, x, i) = base_m(y, x) + base_s(y, x) * 2^(i - 1);
            else
                bd_tumor(y, x) = 0;
            end
        end
    end
end

figure(4)
for i = 1 : 4
    subplot(2, 2, i)
    imagesc(bd_tumor(:, :, i)); axis image; axis off;
    title(['Baseline + ' num2str(2^(i-1)) ' * SD'],'FontSize',15);
end

% Q 03_e

