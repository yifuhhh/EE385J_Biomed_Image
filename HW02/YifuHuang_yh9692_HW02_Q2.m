%% Initialize
clear;
close all;
clc;

load matlab_monday_02.mat;

%% Question 2a
[sy, sx, st, sl] = size(DRO1);
x_guess = .01 * ones(3, 1); % initial guess for parameters
LB = zeros(3, 1);  % assume it is a bounded optimization problem. Lower bounds
UB = ones(3, 1);  % upper bounds
ICs = [.1 .1];
options = optimoptions(@lsqnonlin, 'Display', 'iter', 'FunctionTolerance', 1e-8);
params_fit = zeros(sy, sx, 3);

for y = 1 : sy
    for x = 1 : sx
        mea(:, 1) = DRO1(y, x, :, 1);
        mea(:, 2) = DRO1(y, x, :, 2);
        [params_fit(y, x, :)] = lsqnonlin('two_species_fit', x_guess, LB, UB, options, ICs, time, mea, Cp);
    end
end

for i = 1 : 3
    subplot(1, 3, i)
    imagesc(params_fit(:, :, i));
    title(['Parameter: k' num2str(i)]);
end

%% Question 2b
x_guess = .01 * ones(3, 1); % initial guess for parameters
LB = zeros(3, 1);  % assume it is a bounded optimization problem. Lower bounds
UB = ones(3, 1);  % upper bounds
ICs = [.1 .1];
options = optimoptions(@lsqnonlin, 'Display', 'iter', 'FunctionTolerance', 1e-8);
params_fit = zeros(3, 3);

for i = 1 : 3
    mea(:, 1) = DRO2(i, :, 1); %CT
    mea(:, 2) = DRO2(i, :, 2); %CIC
    [params_fit(i, :)] = lsqnonlin('two_species_fit', x_guess, LB, UB, options, ICs, time, mea, Cp, i);
end

k = [0.1, 0.2, 0.05];
erro = zeros(3, 3);
for i = 1 : 3
    for j = 1 : 3
        erro(i, j) = (params_fit(i, j) - k(j)) / k(j);
    end
end

%% Question 2c
x_guess = .01 * ones(3, 1); % initial guess for parameters
LB = zeros(3, 1);  % assume it is a bounded optimization problem. Lower bounds
UB = ones(3, 1);  % upper bounds
ICs = [.1 .1];
options = optimoptions(@lsqnonlin, 'Display', 'iter', 'FunctionTolerance', 1e-8);

clear time_s;
clear mea;
time_s = time(:);
params_fit = zeros(1, 3);
mea(:, 2) = DRO3(1, :, 1); %CT, high concerntration
mea(:, 1) = DRO3(1, :, 2); %Cp, high concerntration
[params_fit] = lsqnonlin('two_species_fit', x_guess, LB, UB, options, ICs, time_s, mea, Cp);
p(1, :) = params_fit(:);

clear time_s;
clear mea;
time_s = time(1 : 10 : end);
params_fit = zeros(1, 3);
mea(:, 2) = DRO3(1, 1 : 10 : end, 1); %CT, high concerntration
mea(:, 1) = DRO3(1, 1 : 10 : end, 2); %Cp, high concerntration
[params_fit] = lsqnonlin('two_species_fit', x_guess, LB, UB, options, ICs, time_s, mea, Cp);
p(2, :) = params_fit(:);

clear time_s;
clear mea;
time_s = time(1 : 40 : end);
params_fit = zeros(1, 3);
mea(:, 2) = DRO3(1, 1 : 40 : end, 1); %CT, high concerntration
mea(:, 1) = DRO3(1, 1 : 40 : end, 2); %Cp, high concerntration
[params_fit] = lsqnonlin('two_species_fit', x_guess, LB, UB, options, ICs, time_s, mea, Cp);
p(3, :) = params_fit(:);

k = [0.8, 0.2, 0.1];
erro = zeros(3, 3);
for i = 1 : 3
    for j = 1 : 3
        erro(i, j) = (p(i, j) - k(j)) / k(j);
    end
end