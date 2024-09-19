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
    

%for k = 1:1:4 %k represent the # of acceleration values that we want to test
    %a = 1.8*3600/1000 ;   % acceleration (km/h/s)
    if a < 0     % if a is -ve 
        L_CO2 = M_CO2;      % use the coefficiants of Negative acceleration
        L_fuel = M_fuel;
       
    end
    %for i = 1:1:6
        %s = [20, 40, 60, 80, 100, 120] ; % speed (km/h) 
        % to calculate eq#3
        MOE1_CO2 = 0;
        MOE1_fuel = 0;
        
        
        for j=1:1:4
            MOE1_CO2 = L_CO2(1,j)*s^0*a^(j-1) + MOE1_CO2;
            MOE1_fuel = L_fuel(1,j)*s^0*a^(j-1) + MOE1_fuel;
           
        end
        
        MOE2_CO2 = 0;
        MOE2_fuel = 0;
       
        
        for j=1:1:4
            MOE2_CO2 = L_CO2(2,j)*s^1*a^(j-1) + MOE2_CO2;
            MOE2_fuel = L_fuel(2,j)*s^1*a^(j-1) + MOE2_fuel;
           
        end
        
        MOE3_CO2 = 0;
        MOE3_fuel = 0;
        
        
        for j=1:1:4
            MOE3_CO2 = L_CO2(3,j)*s^2*a^(j-1) + MOE3_CO2;
            MOE3_fuel = L_fuel(3,j)*s^2*a^(j-1) + MOE3_fuel;
           
        end
        
        MOE4_CO2 = 0;
        MOE4_fuel = 0;
       
        
        for j=1:1:4
            MOE4_CO2 = L_CO2(4,j)*s^3*a^(j-1) + MOE4_CO2;
            MOE4_fuel = L_fuel(4,j)*s^3*a^(j-1) + MOE4_fuel;
           
        end
        
            MOE.CO2 = exp(MOE1_CO2 + MOE2_CO2 + MOE3_CO2 + MOE4_CO2); % mg/s
            MOE.Fuel = exp(MOE1_fuel + MOE2_fuel + MOE3_fuel + MOE4_fuel); % L/s
          
        end


