mm = 1e-3;

dc = 16.9*mm; 
ti = 1.4*mm; 
txlpe = 9*mm;
to = 1.4*mm; 
tt = 0.6*mm;
tms = 2.3*mm; 
tacs = 2.5*mm; 

tbed = 3*mm; 
ta = 5*mm; 
tos = 4*mm;
% 
% dist_cab = dc +2*(ti+txlpe+to+tt+tms+tacs);
% h = dist_cab *sin(pi/3);
% 
% r_bed_in = 2*h/3+dist_cab/2;
% (r_bed_in+tbed+ta+tos)*2
ticks = [dc/2; dc/2+ti; dc/2+ti+txlpe; dc/2+ti+txlpe+to; dc/2+ti+txlpe+to+tt; dc/2+ti+txlpe+to+tt+tms; dc/2+ti+txlpe+to+tt+tms+tacs]*1e3;

x = (emcut(:,1) - emcut(1,1))*1e3; %[mm]
load('emcut.mat','emcut')

figure;
plot(x,emcut(:,2)*1e-6, 'LineWidth', 1)
title('E field in the 2nd phase')
xlabel('Distance [mm]')
ylabel('E field [kV/mm]')
ylim([0,7])
%xticks(ticks)
grid on
