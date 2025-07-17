clc;
clear all;
s=tf('s');
Vin= 200; % RMS AC Voltage
Vinmin=85;
Vinmax=265;
Vout= 390; % Dutput Voltage
Pout= 3.6e3; %Output Power
Fline= 50; % Supply Frequrncy
Fsw= 40e3; % Switching Frequency of Converter
Iripple = 0.3; % 30% riipple consider
Vripple= 0.01; % 1% ripple Consider
Eff= 0.95; % 95% Efficiency consider
ILrms = (Pout)/(Eff*Vinmin);
ILpeak = sqrt(2)*ILrms;
D=1-(Vinmin/Vout);
L= (sqrt(2) *Vin*D)/(Fsw*Iripple*ILpeak);
Cout= (Pout/Vout)/(2*pi*Fline*Vout*Vripple);
R=(Vout^2/Pout);

%% Controller Design
NUM1=[Vout*Cout (2*Vout)/R];
DEN1=[L*Cout L/R (1-D)^2];
Gid_s=tf(NUM1, DEN1)
%margin(Gid_s)
gain1=0.1
kp1=0.1614;
ki1=50;
cont1= kp1+(ki1/s)
%margin(Gid_s*cont1*gain1)
NUM2=[-L R*(1-D)^2];
DEN2=[(1-D)*R*Cout 2* (1-D)];
Gvi_s=tf(NUM2, DEN2);
%margin(Gvi_s)
gain2=1;
kp2=0.3;
ki2=2;
cont2= kp2+(ki2/s)
%margin(Gvi_s*cont2*gain2)




