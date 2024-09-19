 % Test Inputs
    speed = 60;  % speed in km/h
    acc = 0;     % positive acceleration in km/h/s
    dec = 0;     % no deceleration

    % Run the Function
    MOE = VT_Micro(speed, acc, dec);

    % Display Results
    disp('CO2: ' + string(MOE.CO2) + ' mg/s');
    disp('Fuel: ' + string(MOE.Fuel) + ' L/s');
    
function MOE = VT_Micro(speed,acc,dec)
% This file is the VT-Micro Model to calculate the fuel and emissions
% L has the coefficiants for Positive acceleration & M for Negative acceleration

if acc==0 && dec ~= 0
a = -dec *3600/1000;    % -ve acceleration (km/h/s)
if a < -5
    a = -5; % the deceleratin must not be < -5 kph/s
end
else if acc ~=0 && dec == 0
        a = acc*3600/1000;    % +ve acceleration (km/h/s)
    else
        a = 0;
    end
end

s = speed * 3600/1000; % speed in km/h

L_CO2 = [6.914935279,   0.2173,         0.00023538,     -0.00036388;
        0.02754,       0.00968,        -0.00175,       8.35E-05;
        -0.00020699,	-0.00010138,	0.00001966,     -1.02E-06;
        9.80E-07,   	3.66E-07,       -1.08E-07,      8.50E-09];
    
M_CO2 = [6.914935279,	-0.03203,       -0.00917,       -0.0002886;
        0.02843,   	0.00853,        0.00115,    	-3.06E-06;
        -0.00022659,	-0.00006594,	-0.00001289,	-2.68E-07;
        1.11E-06,   	3.20E-07,   	7.56E-08,   	2.95E-09];

L_fuel= [-7.73452,	0.22946,	-0.00561,	0.00009773;
        0.02799,	0.0068,	-0.00077221,	0.00000838;
        -0.0002228,	-0.00004402,	7.90E-07,	8.17E-07;
        1.09E-06,	4.80E-08,	3.27E-08,	-7.79E-09];

M_fuel = [-7.73452,	-0.01799,	-0.00427,	0.00018829;
         0.02804,	0.00772,	0.00083744,	-0.00003387;
        -0.00021988,	-0.00005219,	-7.44E-06,	2.77E-07;
        1.08E-06,	2.47E-07,	4.87E-08,	3.79E-10];
    
L_HC = [-0.909074721,	0.11863,	0.00379,	2.22E-04;
        0.04189,	-0.00883,	2.43E-03,	-0.00017612;
        -0.00065862,	0.00023592,	0.00000979,	0.00000103;
        4.00E-06,	-5.96E-07,	-2.02E-07,	-2.44E-08];
 
M_HC = [-0.909074721,	-0.14428,	-0.01287,	-1.00E-03;
        0.03132,	0.02164,	3.14E-03,	0.00017181;
        -0.00032229,	-0.00038224,	-0.00004446,	-0.00000117;
        1.77E-06,	1.82E-06,	1.79E-07,	3.32E-10];
    
L_CO = [0.536115279,	0.34035,	-0.01806,	0.00144;
        0.09477,	-0.03006,	0.00742,	-0.00046903;
        -0.00141,	0.00087632,	-0.0001435,	1.02E-05;
        7.67E-06,	-4.71E-06,	8.09E-07,	-9.09E-08];
    
M_CO = [0.536115279,	-0.02867,	0.03164,	0.00504;
        0.08851,	0.0193,	-0.00040576,	-0.00036151;
        -0.00113,	-0.00027067,	0.00003309,	8.85E-06;
        5.50E-06,	1.05E-06,	-2.36E-07,	-4.90E-08];

L_Nox = [-1.080284721,	0.23686,	0.00147,	-0.00007822;
        0.01791,	0.04053,	-0.00375,	0.00010522;
        0.00024118,	-0.00040783,	-0.00001284,	1.52E-06;
        -1.06E-06,	9.42E-07,	1.86E-07,	4.42E-09];
    
M_Nox = [-1.080284721,	0.20845,	0.02193,	0.00088155;
        0.02111,	0.01067,	0.00655,	0.00062653;
        0.00016295,	-0.0000323,	-0.00009429,	-1.01E-05;
        -5.83E-07,	1.83E-07,	4.47E-07,	4.57E-08];

%for k = 1:1:4 %k represent the # of acceleration values that we want to test
    %a = 1.8*3600/1000 ;   % acceleration (km/h/s)
    if a < 0     % if a is -ve 
        L_CO2 = M_CO2;      % use the coefficiants of Negative acceleration
        L_fuel = M_fuel;
        L_HC = M_HC;
        L_CO = M_CO;
        L_Nox = M_Nox;
    end
    %for i = 1:1:6
        %s = [20, 40, 60, 80, 100, 120] ; % speed (km/h) 
        % to calculate eq#3
        MOE1_CO2 = 0;
        MOE1_fuel = 0;
        MOE1_HC = 0;
        MOE1_CO = 0;
        MOE1_Nox = 0;
        
        for j=1:1:4
            MOE1_CO2 = L_CO2(1,j)*s^0*a^(j-1) + MOE1_CO2;
            MOE1_fuel = L_fuel(1,j)*s^0*a^(j-1) + MOE1_fuel;
            MOE1_HC = L_HC(1,j)*s^0*a^(j-1) + MOE1_HC;
            MOE1_CO = L_CO(1,j)*s^0*a^(j-1) + MOE1_CO;
            MOE1_Nox = L_Nox(1,j)*s^0*a^(j-1) + MOE1_Nox;
        end
        
        MOE2_CO2 = 0;
        MOE2_fuel = 0;
        MOE2_HC = 0;
        MOE2_CO = 0;
        MOE2_Nox = 0;
        
        for j=1:1:4
            MOE2_CO2 = L_CO2(2,j)*s^1*a^(j-1) + MOE2_CO2;
            MOE2_fuel = L_fuel(2,j)*s^1*a^(j-1) + MOE2_fuel;
            MOE2_HC = L_HC(2,j)*s^1*a^(j-1) + MOE2_HC;
            MOE2_CO = L_CO(2,j)*s^1*a^(j-1) + MOE2_CO;
            MOE2_Nox = L_Nox(2,j)*s^1*a^(j-1) + MOE2_Nox;
        end
        
        MOE3_CO2 = 0;
        MOE3_fuel = 0;
        MOE3_HC = 0;
        MOE3_CO = 0;
        MOE3_Nox = 0;
        
        for j=1:1:4
            MOE3_CO2 = L_CO2(3,j)*s^2*a^(j-1) + MOE3_CO2;
            MOE3_fuel = L_fuel(3,j)*s^2*a^(j-1) + MOE3_fuel;
            MOE3_HC = L_HC(3,j)*s^2*a^(j-1) + MOE3_HC;
            MOE3_CO = L_CO(3,j)*s^2*a^(j-1) + MOE3_CO;
            MOE3_Nox = L_Nox(3,j)*s^2*a^(j-1) + MOE3_Nox;
        end
        
        MOE4_CO2 = 0;
        MOE4_fuel = 0;
        MOE4_HC = 0;
        MOE4_CO = 0;
        MOE4_Nox = 0;
        
        for j=1:1:4
            MOE4_CO2 = L_CO2(4,j)*s^3*a^(j-1) + MOE4_CO2;
            MOE4_fuel = L_fuel(4,j)*s^3*a^(j-1) + MOE4_fuel;
            MOE4_HC = L_HC(4,j)*s^3*a^(j-1) + MOE4_HC;
            MOE4_CO = L_CO(4,j)*s^3*a^(j-1) + MOE4_CO;
            MOE4_Nox = L_Nox(4,j)*s^3*a^(j-1) + MOE4_Nox;
        end
        
            MOE.CO2 = exp(MOE1_CO2 + MOE2_CO2 + MOE3_CO2 + MOE4_CO2); % mg/s
            MOE.Fuel = exp(MOE1_fuel + MOE2_fuel + MOE3_fuel + MOE4_fuel); % L/s
            MOE.HC = exp(MOE1_HC + MOE2_HC + MOE3_HC + MOE4_HC); % mg/s
            MOE.CO = exp(MOE1_CO + MOE2_CO + MOE3_CO + MOE4_CO); % mg/s
            MOE.Nox = exp(MOE1_Nox + MOE2_Nox + MOE3_Nox + MOE4_Nox); % mg/s

end

