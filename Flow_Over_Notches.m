clc;
clear;
close all;

% =========================================================
%              FLOW OVER NOTCHES
%              MATLAB PROJECT
% =========================================================

% =========================================================
% 1. CONSTANTS
% =========================================================

g = 9.81;          % Acceleration due to gravity (m/s^2)
A = 0.1;           % Measuring tank area (m^2)
L = 0.065;         % Rectangular notch width (m)

fprintf('\n');
fprintf('====================================================\n');
fprintf('                 FLOW OVER NOTCHES\n');
fprintf('                  MATLAB PROJECT\n');
fprintf('====================================================\n');

fprintf('\nCONSTANTS\n');
fprintf('----------------------------------------------------\n');
fprintf('Gravity                  = %.2f m/s^2\n', g);
fprintf('Measuring Tank Area      = %.3f m^2\n', A);
fprintf('Rectangular Notch Width  = %.3f m\n', L);

% =========================================================
% 2. NUMBER OF READINGS
% =========================================================

n = input('\nEnter number of readings: ');

if n <= 0 || floor(n) ~= n
    error('Number of readings must be a positive integer.');
end

% =========================================================
% 3. CREATE ARRAYS
% =========================================================

H = zeros(1,n);          % Water head (cm)
R = zeros(1,n);          % Rise of water level (cm)
t = zeros(1,n);          % Time (s)

Q = zeros(1,n);          % Actual discharge (m^3/s)

Cd_Rect = zeros(1,n);    % Cd for rectangular notch
Cd_45 = zeros(1,n);      % Cd for 45 degree V-notch
Cd_60 = zeros(1,n);      % Cd for 60 degree V-notch

% =========================================================
% 4. ENTER EXPERIMENTAL READINGS
% =========================================================

fprintf('\n');
fprintf('====================================================\n');
fprintf('              EXPERIMENTAL READINGS\n');
fprintf('====================================================\n');

for i = 1:n

    fprintf('\n---------------- Reading %d ----------------\n', i);

    H(i) = input('Enter water head H (cm): ');
    R(i) = input('Enter rise of water level R (cm): ');
    t(i) = input('Enter time t (s): ');

    % Check values
    if H(i) <= 0
        error('Water head H must be greater than zero.');
    end

    if R(i) <= 0
        error('Rise R must be greater than zero.');
    end

    if t(i) <= 0
        error('Time must be greater than zero.');
    end

    % =====================================================
    % ACTUAL DISCHARGE
    % Q = A*R/(t*100)
    % R is in cm, therefore divide by 100
    % =====================================================

    Q(i) = (A * R(i)) / (t(i) * 100);

    % Convert head from cm to m
    H_m = H(i) / 100;

    % =====================================================
    % RECTANGULAR NOTCH
    %
    % Q = (2/3)*Cd*L*sqrt(2g)*H^(3/2)
    %
    % Cd = 3Q/[2L*sqrt(2g)*H^(3/2)]
    % =====================================================

    Cd_Rect(i) = (3 * Q(i)) / ...
        (2 * L * sqrt(2*g) * H_m^(3/2));

end

% =========================================================
% 5. CALCULATE Cd FOR 45 DEGREE V-NOTCH
% =========================================================

theta45 = 45;

for i = 1:n

    H_m = H(i) / 100;

    % Q = (8/15)*Cd*tan(theta/2)*sqrt(2g)*H^(5/2)

    Cd_45(i) = (15 * Q(i)) / ...
        (8 * tan(deg2rad(theta45/2)) * sqrt(2*g) * H_m^(5/2));

end

% =========================================================
% 6. CALCULATE Cd FOR 60 DEGREE V-NOTCH
% =========================================================

theta60 = 60;

for i = 1:n

    H_m = H(i) / 100;

    % Q = (8/15)*Cd*tan(theta/2)*sqrt(2g)*H^(5/2)

    Cd_60(i) = (15 * Q(i)) / ...
        (8 * tan(deg2rad(theta60/2)) * sqrt(2*g) * H_m^(5/2));

end

% =========================================================
% 7. CALCULATE AVERAGE Cd
% =========================================================

Cd_Rect_Avg = mean(Cd_Rect);
Cd_45_Avg = mean(Cd_45);
Cd_60_Avg = mean(Cd_60);

% =========================================================
% 8. DISPLAY RECTANGULAR NOTCH RESULTS
% =========================================================

fprintf('\n\n');
fprintf('====================================================\n');
fprintf('             RECTANGULAR NOTCH RESULTS\n');
fprintf('====================================================\n');

for i = 1:n

    fprintf('Reading %d : Q = %.6f m^3/s    Cd = %.4f\n', ...
        i, Q(i), Cd_Rect(i));

end

fprintf('----------------------------------------------------\n');
fprintf('Average Cd for Rectangular Notch = %.4f\n', ...
    Cd_Rect_Avg);

% =========================================================
% 9. DISPLAY 45 DEGREE V-NOTCH RESULTS
% =========================================================

fprintf('\n\n');
fprintf('====================================================\n');
fprintf('              45 DEGREE V-NOTCH RESULTS\n');
fprintf('====================================================\n');

for i = 1:n

    fprintf('Reading %d : Q = %.6f m^3/s    Cd = %.4f\n', ...
        i, Q(i), Cd_45(i));

end

fprintf('----------------------------------------------------\n');
fprintf('Average Cd for 45 Degree V-Notch = %.4f\n', ...
    Cd_45_Avg);

% =========================================================
% 10. DISPLAY 60 DEGREE V-NOTCH RESULTS
% =========================================================

fprintf('\n\n');
fprintf('====================================================\n');
fprintf('              60 DEGREE V-NOTCH RESULTS\n');
fprintf('====================================================\n');

for i = 1:n

    fprintf('Reading %d : Q = %.6f m^3/s    Cd = %.4f\n', ...
        i, Q(i), Cd_60(i));

end

fprintf('----------------------------------------------------\n');
fprintf('Average Cd for 60 Degree V-Notch = %.4f\n', ...
    Cd_60_Avg);

% =========================================================
% 11. OBSERVATION TABLE
% =========================================================

Results = table( ...
    (1:n)', ...
    H', ...
    R', ...
    t', ...
    Q', ...
    Cd_Rect', ...
    Cd_45', ...
    Cd_60', ...
    'VariableNames', { ...
    'Reading', ...
    'H_cm', ...
    'R_cm', ...
    'Time_s', ...
    'Q_m3_s', ...
    'Cd_Rectangular', ...
    'Cd_45_Degree', ...
    'Cd_60_Degree'});

fprintf('\n\n');
fprintf('====================================================\n');
fprintf('                 OBSERVATION TABLE\n');
fprintf('====================================================\n');

disp(Results);

% =========================================================
% 12. FINAL RESULTS
% =========================================================

fprintf('\n');
fprintf('====================================================\n');
fprintf('                   FINAL RESULTS\n');
fprintf('====================================================\n');

fprintf('\nAverage Coefficient of Discharge:\n\n');

fprintf('Rectangular Notch       = %.4f\n', Cd_Rect_Avg);
fprintf('45 Degree V-Notch       = %.4f\n', Cd_45_Avg);
fprintf('60 Degree V-Notch       = %.4f\n', Cd_60_Avg);

% =========================================================
% 13. GRAPH 1
% DISCHARGE VS WATER HEAD
% =========================================================

figure;

plot(H, Q, 'o-', ...
    'LineWidth', 2, ...
    'MarkerSize', 8);

grid on;

xlabel('Water Head, H (cm)');
ylabel('Actual Discharge, Q (m^3/s)');
title('Discharge vs Water Head');

% =========================================================
% 14. GRAPH 2
% AVERAGE Cd COMPARISON
% =========================================================

figure;

Cd_Average_Values = [ ...
    Cd_Rect_Avg, ...
    Cd_45_Avg, ...
    Cd_60_Avg];

bar(Cd_Average_Values);

grid on;

xlabel('Type of Notch');
ylabel('Average Coefficient of Discharge, C_d');

title('Comparison of Average Coefficient of Discharge');

xticks(1:3);

xticklabels({ ...
    'Rectangular', ...
    '45 Degree V-Notch', ...
    '60 Degree V-Notch'});

% =========================================================
% 15. GRAPH 3
% Cd VS READING NUMBER
% =========================================================

figure;

Reading_Number = 1:n;

plot(Reading_Number, Cd_Rect, 'o-', ...
    'LineWidth', 2, ...
    'MarkerSize', 8);

hold on;

plot(Reading_Number, Cd_45, 's-', ...
    'LineWidth', 2, ...
    'MarkerSize', 8);

plot(Reading_Number, Cd_60, '^-', ...
    'LineWidth', 2, ...
    'MarkerSize', 8);

grid on;

xlabel('Reading Number');
ylabel('Coefficient of Discharge, C_d');

title('Coefficient of Discharge for Different Notches');

legend( ...
    'Rectangular Notch', ...
    '45 Degree V-Notch', ...
    '60 Degree V-Notch', ...
    'Location', 'best');

hold off;

% =========================================================
% 16. CONCLUSION
% =========================================================

fprintf('\n\n');
fprintf('====================================================\n');
fprintf('                    CONCLUSION\n');
fprintf('====================================================\n');

fprintf('\n');
fprintf('The coefficient of discharge was determined for\n');
fprintf('Rectangular, 45 Degree V-Notch and 60 Degree V-Notch.\n');

fprintf('\n');
fprintf('The actual discharge was calculated using the\n');
fprintf('measuring tank area, rise of water level and time.\n');

fprintf('\n');
fprintf('Average Cd values obtained are:\n');

fprintf('Rectangular Notch       = %.4f\n', Cd_Rect_Avg);
fprintf('45 Degree V-Notch       = %.4f\n', Cd_45_Avg);
fprintf('60 Degree V-Notch       = %.4f\n', Cd_60_Avg);

fprintf('\n');
fprintf('====================================================\n');
fprintf('              PROGRAM COMPLETED\n');
fprintf('====================================================\n');

% =========================================
% TEST GRAPH
% =========================================

figure('Name','Discharge vs Water Head','NumberTitle','off');

plot(H, Q, 'o-', 'LineWidth', 2, 'MarkerSize', 8);

grid on;

xlabel('Water Head H (cm)');
ylabel('Actual Discharge Q (m^3/s)');
title('Discharge vs Water Head');
drawnow;
