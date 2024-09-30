
%% Sigmoid Fit for Both LS1 and EV %%

%% Calculatting the fit %%
% Define the LS1 variables
LS1_concentrations = [1, 10, 100, 1000];    % Concentrations
LS1_gMFI = [120, 423, 2375, 16966];  % gMFI values for LS1

% Define the EV variables
EV_concentrations = [1, 10, 100, 1000];    % Concentrations for EV
EV_gMFI = [95.4 , 248, 1744, 46886];  % gMFI values for EV

% Sigmoid model for both LS1 and EV
ft_sigmoid = fittype('a / (1 + exp(-b * (x - c)))');  % Sigmoid fit as per MATLAB guidelines (https://www.mathworks.com/help/curvefit/sigmoidal.html)

% Perform the fit for LS1
[fit_result_LS1, gof_LS1] = fit(LS1_concentrations', LS1_gMFI', ft_sigmoid, 'StartPoint', [20000, 0.01, 500]); % [setting initial guesses .a, .b and .c] 

% Perform the fit for EV
[fit_result_EV, gof_EV] = fit(EV_concentrations', EV_gMFI', ft_sigmoid, 'StartPoint', [50000, 0.01, 500]); % [setting initial guesses .a, .b and .c]

%% Plotting the fit %%
% Plotting the data with sigmoid fit in log-log scale
figure;
loglog(LS1_concentrations, LS1_gMFI, 'bo-', 'MarkerSize', 8, 'DisplayName', 'LS1 Data'); % Plot LS1 Data points
hold on;
loglog(EV_concentrations, EV_gMFI, 'g^-', 'MarkerSize', 8, 'DisplayName', 'EV Data'); % Plot EV Data points

% Generate points for the fitted curves (log scale for plotting)
x_fit = logspace(0, 3, 100);  % Generate 100 values between 10^0 and 10^3

% Plot LS1 fitted line using the sigmoid fit in log-log scale
y_fit_LS1 = fit_result_LS1.a ./ (1 + exp(-fit_result_LS1.b * (x_fit - fit_result_LS1.c)));  % Sigmoid for LS1
loglog(x_fit, y_fit_LS1, 'b--', 'LineWidth', 2, 'DisplayName', 'LS1 Sigmoid Fit');

% Plot EV fitted line using the sigmoid fit in log-log scale
y_fit_EV = fit_result_EV.a ./ (1 + exp(-fit_result_EV.b * (x_fit - fit_result_EV.c)));  % Sigmoid for EV
loglog(x_fit, y_fit_EV, 'g--', 'LineWidth', 2, 'DisplayName', 'EV Sigmoid Fit');

% Customize the plot
title('Titration Curve for Both LIPSTIC and EV (Sigmoid Fit)');
xlabel('Concentration in µL (log scale)');
ylabel('gMFI (log scale)');
ylim([10^1 10^5]) 
xlim([10^-1 10^3])
legend('show', 'Location', 'southeast');
grid on;

% Display R² values for both fits
text(10, 8000, ['LS1 R^2 = ', num2str(gof_LS1.rsquare, 3)], 'FontSize', 12, 'Color', 'b');
text(10, 40000, ['EV R^2 = ', num2str(gof_EV.rsquare, 3)], 'FontSize', 12, 'Color', 'g');

% Draw the baseline fluorescence in log-log scale
baseline_value = 75.8;  % Set the y-value for the baseline
line([1, 1000], [baseline_value, baseline_value], 'Color', 'k', 'LineStyle', '--', 'LineWidth', 2, 'DisplayName', 'Baseline');

hold off;


%% Plot histogram for fluorescence at highest concentrations %%
%% Calculate SEM%% 

% Define weighted average values (manually calculated in excel)
mean_LS1 = 15488; 
mean_EV = 42417;   

%% Calculate the standard deviation for LS1 (manual)
% Step 1: Subtract mean from each data point and square the result
squared_diff_LS1 = (LS1_gMFI - mean_LS1).^2;

% Step 2: Sum all squared values
sum_squared_diff_LS1 = sum(squared_diff_LS1);

% Step 3: Divide by (n-1) for sample standard deviation
variance_LS1 = sum_squared_diff_LS1 / (n_LS1 - 1);

% Step 4: Take the square root to get standard deviation
std_LS1 = sqrt(variance_LS1);

%% Calculate the standard deviation for EV (manual)
% Step 1: Subtract mean from each data point and square the result
squared_diff_EV = (EV_gMFI - mean_EV).^2;

% Step 2: Sum all squared values
sum_squared_diff_EV = sum(squared_diff_EV);

% Step 3: Divide by (n-1) for sample standard deviation
variance_EV = sum_squared_diff_EV / (n_EV - 1);

% Step 4: Take the square root to get standard deviation
std_EV = sqrt(variance_EV);

%% Standard Error calculation and Plot %%
% Calculate the standard error for LS1 and EV
sem_LS1 = std_LS1 / sqrt(n_LS1)  
sem_EV = std_EV / sqrt(n_EV)     

% Calculate the max and min for LS1
upper_error_LS1 = mean_LS1 + sem_LS1
lower_error_LS1 = mean_LS1 - sem_LS1 

% Calculte the max and min for EV
upper_error_EV = mean_EV + sem_EV
lower_error_EV = mean_EV - sem_EV

% Plot the data
figure;
bar(1, mean_LS1, 'b');  % Bar for LS1
hold on;
bar(2, mean_EV, 'g');   % Bar for EV

% Add error bars
errorbar(1, mean_LS1, lower_error_LS1 - mean_LS1, upper_error_LS1 - mean_LS1, 'k', 'LineWidth', 2);  % LS1 error bars
errorbar(2, mean_EV, lower_error_EV - mean_EV, upper_error_EV - mean_EV, 'k', 'LineWidth', 2);      % EV error bars

% Customize plot
set(gca, 'XTick', [1, 2], 'XTickLabel', {'LS1 1000 µL', 'EV 1000 µL'}, 'FontSize', 14);
ylabel('gMFI', 'FontSize', 14);
title('Comparison of gMFI Values for EV and LS1', 'FontSize', 16); 
grid on;
hold off;