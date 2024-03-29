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
imagesc(base_m); axis image; axis off; title('Baseline signal density','FontSize',20);
subplot(1, 2, 2)
imagesc(base_s); axis image; axis off; title('Standard deviation','FontSize',20);

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
plot(tumor_x, tumor_y, 'r', 'LineWidth', 3)
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
title('Maximum value of each voxel');
axis image
colormap hot
colorbar

% Q 03_d

bd_tumor = zeros(75, 70, 4);
for i = 1 : 4
    for y = 1 : sy
        for x = 1 : sx
            if tumor_mask(y, x) == 1
                for j = 1 : 199
                    if bm(y, x, j) > (base_m(y, x) + base_s(y, x) * 2^(i - 1))
                        bd_tumor(y, x, i) = bd_tumor(y, x, i) + 1;
                    end
                end
            else
                bd_tumor(y, x, i) = 0;
            end
        end
    end
end

figure(4)
for i = 1 : 4
    subplot(2, 2, i)
    imagesc(bd_tumor(:, :, i), [0, 199]); axis image; axis off;
    title(['# of timepoint > Baseline + ' num2str(2^(i-1)) ' * SD'],'FontSize',12);
    colormap hot
    colorbar
end

% Q 03_e

mloc = zeros(75, 70);
for y = 1 : sy
    for x = 1 : sx
        if tumor_mask(y, x) == 1
            m = max(bm(y, x, :));
            [ym, xm] = find(bm(y, x, :) == m);
            mloc(y, x) = xm;
        else
            mloc(y, x) = 1000;
        end
    end
end

figure(5)
imagesc(mloc, [1, 199]); axis image; axis off;
title('Time point of max value');
colormap hot
colorbar

%% Q 04

p_guess = [0.1, 0.1];
LB = [0, 0];

params_fit = zeros(75, 70, 2);
for y = 1 : sy
    for x = 1 : sx
        truth(:) = bm(y, x, :) / base_m(y, x);
        [params_fit(y, x, :)] = lsqcurvefit('poly3model', p_guess, t, truth, LB);
    end
end

for y = 1 : sy
    for x = 1 : sx
        if tumor_mask(y, x) == 0
            params_fit(y, x, 1) = 0;
            params_fit(y, x, 2) = 0;
        end
    end
end

for i = 1 : 2
    subplot(1, 2, i);
    imagesc(params_fit(:, :, i)); axis image; axis off;
    title(['P' num2str(i) ' within the tumor'],'FontSize',15);
    colormap hot
    colorbar
end