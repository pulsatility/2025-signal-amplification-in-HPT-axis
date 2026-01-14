clear all
clc
% Time unit: hour

tspan = [0:10:10000];

color_TRH = [75/255, 186/255, 253/255];
color_TSH = [126/255, 210/255, 134/255];
color_TH  = [255/255, 153/255, 203/255];

%% Initial condition
init.TRH = 1;
init.TSH = 1;
init.TH = 15;
init_default = init;


%% -------------------------- DESIGN A run to steady state-----------------------------------------------%%
% Load parameters
load('Default_param_A.mat');
param = param_default;

% Run simulation
y0 = [init.TRH, init.TSH, init.TH];
[t,y] = ode15s('HPT_ode',tspan, y0, [], param); %Note: use @HPT_ode does not work for passing argument

% Plot time-course
figure(1)
hold on
plot(t,y(:,1))
xlabel('Time (h)')
ylabel('TRH)')

figure(2)
hold on
plot(t,y(:,2))
xlabel('Time (h)')
ylabel('TSH (mIU/L)')

figure(3)
hold on
plot(t,y(:,3))
xlabel('Time (h)')
ylabel('TH (pM)')

% Obtain steady-state values
TRHss = y(end,1);
TSHss = y(end,2);
THss = y(end,3);


%% -------------------------- DESIGN A Sensitivity Analysis -----------------------------------------------%%

param_cell = struct2cell(param_default);

param_names = fieldnames(param_default);

percent_change = 0.1; % for parameter change 


% Increasing parameter values
SC_TRH_increase = [];
SC_TSH_increase  = [];
SC_TH_increase  = [];

for i = 1:1:length(param_cell)
    param = param_default;
    eval(strcat('param.', param_names{i}, '=', num2str(param_cell{i}), '*(1 + percent_change);'));
    y0 = [init.TRH, init.TSH, init.TH];
    [t,y] = ode15s('HPT_ode',tspan, y0, [], param);

    % Plot time-course
    figure(1)
    hold on
    plot(t,y(:,1))
    xlabel('Time (h)')
    ylabel('TRH)')
    
    figure(2)
    hold on
    plot(t,y(:,2))
    xlabel('Time (h)')
    ylabel('TSH (mIU/L)')
    
    figure(3)
    hold on
    plot(t,y(:,3))
    xlabel('Time (h)')
    ylabel('TH (pM)')
    
    % Obtain steady-state values
    TRHss_increase = y(end,1);
    TSHss_increase = y(end,2);
    THss_increase = y(end,3);

    %Calculate sensitivity coefficient (SC)
    SC_TRH_increase = [SC_TRH_increase, (TRHss_increase - TRHss)/TRHss/percent_change];
    SC_TSH_increase = [SC_TSH_increase, (TSHss_increase - TSHss)/TSHss/percent_change];
    SC_TH_increase  = [SC_TH_increase, (THss_increase  - THss)/THss/percent_change];

end

% Decreasing parameter values
SC_TRH_decrease = [];
SC_TSH_decrease  = [];
SC_TH_decrease  = [];

for i = 1:1:length(param_cell)
    param = param_default;
    eval(strcat('param.', param_names{i}, '=', num2str(param_cell{i}), '*(1 - percent_change);'));
    y0 = [init.TRH, init.TSH, init.TH];
    [t,y] = ode15s('HPT_ode',tspan, y0, [], param);

    % Plot time-course
    figure(1)
    hold on
    plot(t,y(:,1))
    xlabel('Time (h)')
    ylabel('TRH)')
    
    figure(2)
    hold on
    plot(t,y(:,2))
    xlabel('Time (h)')
    ylabel('TSH (mIU/L)')
    
    figure(3)
    hold on
    plot(t,y(:,3))
    xlabel('Time (h)')
    ylabel('TH (pM)')
    
    % Obtain steady-state values
    TRHss_decrease = y(end,1);
    TSHss_decrease = y(end,2);
    THss_decrease = y(end,3);

    %Calculate sensitivity coefficient (SC)
    SC_TRH_decrease = [SC_TRH_decrease, -(TRHss_decrease - TRHss)/TRHss/percent_change];
    SC_TSH_decrease = [SC_TSH_decrease, -(TSHss_decrease - TSHss)/TSHss/percent_change];
    SC_TH_decrease  = [SC_TH_decrease, -(THss_decrease  - THss)/THss/percent_change];

end

% Averaging SC
SC_TRH = (SC_TRH_increase + SC_TRH_decrease) / 2;
SC_TSH = (SC_TSH_increase + SC_TSH_decrease) / 2;
SC_TH = (SC_TH_increase + SC_TH_decrease) / 2;


%Plot TRH SC
figure(4)
bar(SC_TRH, 'FaceColor', color_TRH);
ylabel('SC (TRH)');
xticklabels(param_names);
pbaspect([3.6 1 1])
ylim([-1.3,1.2]);
yticks([-1 -0.5 0 0.5 1])
set(gca,'Fontsize', 14);

%Plot TSH SC
figure(5)
bar(SC_TSH, 'FaceColor', color_TSH);
ylabel('SC (TSH)');
xticklabels(param_names);
pbaspect([3.6 1 1])
ylim([-1.2,2]);
yticks([-1 -0.5 0 0.5 1 2])
set(gca,'Fontsize', 14);

%Plot TH SC
figure(6)
bar(SC_TH, 'FaceColor', color_TH);
ylabel('SC (TH)');
xticklabels(param_names);
pbaspect([3.6 1 1])
ylim([-1.2,1.2]);
yticks([-1 -0.5 0 0.5 1])
set(gca,'Fontsize', 14);
%



%% -------------------------- DESIGN B run to steady state-----------------------------------------------%%
% Load parameters
load('Default_param_B.mat');
param = param_default;

% Run simulation
y0 = [init.TRH, init.TSH, init.TH];
[t,y] = ode15s('HPT_ode',tspan, y0, [], param); %Note: use @HPT_ode does not work for passing argument

% Plot time-course
figure(10)
plot(t,y(:,1))
xlabel('Time (h)')
ylabel('TRH)')

figure(20)
plot(t,y(:,2))
xlabel('Time (h)')
ylabel('TSH (mIU/L)')

figure(30)
plot(t,y(:,3))
xlabel('Time (h)')
ylabel('TH (pM)')

% Obtain steady-state values
TRHss = y(end,1);
TSHss = y(end,2);
THss = y(end,3);


%% -------------------------- DESIGN B Sensitivity Analysis -----------------------------------------------%%
param_cell = struct2cell(param_default);

param_names = fieldnames(param_default);

percent_change = 0.1; % for parameter change 


% Increasing parameter values
SC_TRH_increase = [];
SC_TSH_increase  = [];
SC_TH_increase  = [];

for i = 1:1:length(param_cell)
    param = param_default;
    eval(strcat('param.', param_names{i}, '=', num2str(param_cell{i}), '*(1 + percent_change);'));
    y0 = [init.TRH, init.TSH, init.TH];
    [t,y] = ode15s('HPT_ode',tspan, y0, [], param);

    % Plot time-course
    figure(10)
    hold on
    plot(t,y(:,1))
    xlabel('Time (h)')
    ylabel('TRH)')
    
    figure(20)
    hold on
    plot(t,y(:,2))
    xlabel('Time (h)')
    ylabel('TSH (mIU/L)')
    
    figure(30)
    hold on
    plot(t,y(:,3))
    xlabel('Time (h)')
    ylabel('TH (pM)')
    
    % Obtain steady-state values
    TRHss_increase = y(end,1);
    TSHss_increase = y(end,2);
    THss_increase = y(end,3);

    %Calculate sensitivity coefficient (SC)
    SC_TRH_increase = [SC_TRH_increase, (TRHss_increase - TRHss)/TRHss/percent_change];
    SC_TSH_increase = [SC_TSH_increase, (TSHss_increase - TSHss)/TSHss/percent_change];
    SC_TH_increase  = [SC_TH_increase, (THss_increase  - THss)/THss/percent_change];

end

% Decreasing parameter values
SC_TRH_decrease = [];
SC_TSH_decrease  = [];
SC_TH_decrease  = [];

for i = 1:1:length(param_cell)
    param = param_default;
    eval(strcat('param.', param_names{i}, '=', num2str(param_cell{i}), '*(1 - percent_change);'));
    y0 = [init.TRH, init.TSH, init.TH];
    [t,y] = ode15s('HPT_ode',tspan, y0, [], param);

    % Plot time-course
    figure(10)
    hold on
    plot(t,y(:,1))
    xlabel('Time (h)')
    ylabel('TRH)')
    
    figure(20)
    hold on
    plot(t,y(:,2))
    xlabel('Time (h)')
    ylabel('TSH (mIU/L)')
    
    figure(30)
    hold on
    plot(t,y(:,3))
    xlabel('Time (h)')
    ylabel('TH (pM)')
    
    % Obtain steady-state values
    TRHss_decrease = y(end,1);
    TSHss_decrease = y(end,2);
    THss_decrease = y(end,3);

    %Calculate sensitivity coefficient (SC)
    SC_TRH_decrease = [SC_TRH_decrease, -(TRHss_decrease - TRHss)/TRHss/percent_change];
    SC_TSH_decrease = [SC_TSH_decrease, -(TSHss_decrease - TSHss)/TSHss/percent_change];
    SC_TH_decrease  = [SC_TH_decrease, -(THss_decrease  - THss)/THss/percent_change];

end

% Averaging SC
SC_TRH = (SC_TRH_increase + SC_TRH_decrease) / 2;
SC_TSH = (SC_TSH_increase + SC_TSH_decrease) / 2;
SC_TH = (SC_TH_increase + SC_TH_decrease) / 2;


%Plot TRH SC
figure(40)
bar(SC_TRH, 'FaceColor', color_TRH);
ylabel('SC (TRH)');
xticklabels(param_names);
pbaspect([3.6 1 1])
ylim([-1.3,1.2]);
yticks([-1 -0.5 0 0.5 1])
set(gca,'Fontsize', 14);

%Plot TSH SC
figure(50)
bar(SC_TSH, 'FaceColor', color_TSH);
ylabel('SC (TSH)');
xticklabels(param_names);
pbaspect([3.6 1 1])
ylim([-1.2,1.2]);
yticks([-1 -0.5 0 0.5 1])
set(gca,'Fontsize', 14);

%Plot TH SC
figure(60)
bar(SC_TH, 'FaceColor', color_TH);
ylabel('SC (TH)');
xticklabels(param_names);
pbaspect([3.6 1 1])
ylim([-1.2,1.2]);
yticks([-1 -0.5 0 0.5 1])
set(gca,'Fontsize', 14);
%
