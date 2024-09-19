% This code is to calculate SR based on the estimated formula
clear all
d = 12; % the distance b/w vehicle & TLS after receiving the msg (meter)
Delta = 4.8; % 1.38 m/s2 = 5 km/h/s 
Smin = 1.67; % Km/h
Smax = 4.8; % Km/h
smin = Smin * 1000/3600; % m/s
smax = Smax * 1000/3600; % m/s
delta = Delta * 1000/3600; % m/s2
Ty = 1;
Tr = 5;
Tg = 3;
Lg = 1;
D = 5.6;
CL = Ty + Tr + Tg ;
%Ng = ceil((d/smax - Lg) / CL);
Ng = 1;
if d <= Lg * smax  % if the vehicle at smax will pass the current green TLS 
    sr = smax;
else
C = (Ng - 1)*CL + Lg + Ty + Tr - D; % the denominator of the formula
R=[-1/delta smax/delta-C d-smax^(2)/(2*delta)];
S=roots(R);
if( S(1) > 0    &&     S(1) < S(2) )
    sr=S(1);
   else
   if ( S(2) > 0 )
       sr = S(2);
       else
       fprintf(1,'Error. Both solutions are negative!!!');
   end
end
%sr = min(max(sr, smin), smax);
if sr > smax
    sr = smax;
end
if sr < smin
    sr = smin;
end
end
SR = sr * 3600/1000; % to convert from m/s to km/h  SR
