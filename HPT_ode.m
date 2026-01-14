function dydt = HPT_ode(t, y, option, param)


%% -------------------------- PARAMETERS MAPPING ----------------------------------%%

%Manual code but fast to execute

k1 = param.k1;
k2 = param.k2;
k3 = param.k3;
k4 = param.k4;
k5 = param.k5;
k6 = param.k6;
Kd1= param.Kd1;
Kd3= param.Kd3;
Kd5= param.Kd5;
Kd7= param.Kd7;
n1 = param.n1;
n3 = param.n3;
n5 = param.n5;
n7 = param.n7;


%% ------------------------- STATE NAME MAPPING----------------------------%%

TRH    = y(1);
TSH    = y(2);
TH     = y(3);
%

%% ------------------------------ ODEs-------------------------------------%%

dydt = zeros(length(y),1); %make dydt as a column vector as required by MatLab ode function

%TRH
dydt(1) = k5 * Kd5^n5 / (Kd5^n5+TH^n5) - k6*TRH;

%TSH
dydt(2) = k3 * Kd3^n3 / (Kd3^n3+TH^n3) * TRH^n7 / (Kd7^n7+TRH^n7) - k4*TSH;
%dydt(1) = k3 * S^n1 / (K+TRa^n) - k4*TSH; % S represents allostatic neural sigal to TRH neurons and n1 can be slightly lower than n since it
%may bypass the TR-mediated amplification

%TH
dydt(3)	= k1 * TSH^n1 / (Kd1^n1+TSH^n1) - k2*TH;

%

end