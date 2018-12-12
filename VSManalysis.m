close all;
dataCold=csvread("COPDIRMN_FC_25K.csv",1,0);%gets the whole file
dataRoom=csvread("COPDIRMN_FC_300K_00005.csv",1,0);
Fcold=dataCold(:,14);
Froom=dataRoom(:,14);
Mcold=dataCold(:,21);
Mroom=dataRoom(:,21);
Mroom=Mroom./max(Mroom);
Mcold=Mcold./max(Mcold);
%Mcold=smooth(Mcold);%I smooth it twice because otherwise the highpoints 
%Mcold=smooth(Mcold);%on the derivative are noise at the end.
% plot(Fcold,Mcold,Froom,Mroom)
% legend('25K','300K');
% title('VSM data');
% 
% 
% Dcold=diff(Mcold);
% Droom=diff(Mroom);
% 
% FDcold=zeros(size(Dcold));
% for n=1:size(FDcold,1)
%    FDcold(n)=(Fcold(n)+Fcold(n+1))/2; 
% end
% FDroom=zeros(size(Droom));
% for n=1:size(FDroom,1)
%    FDroom(n)=(Froom(n)+Froom(n+1))/2; 
% end
% Droom=Droom./max(Droom);
% Dcold=smooth(Dcold);
% Dcold=Dcold./max(Dcold);
% 
% figure;
% plot(FDcold,Dcold,FDroom,Droom);
% legend('25K','300K');
% title('First Derivatives');
% 
% figure;
% plot(Fcold,Mcold,Froom,Mroom,FDcold,Dcold,FDroom,Droom);
% legend('25k','300k','25k derivative','300k derivative');
% title('Overlaid Plots');
% 
% [~,aIroom]=max(Droom);
% [~,dIroom]=max(-Droom);
% [~,aIcold]=max(Dcold);
% [~,dIcold]=max(-Dcold);
% 
% CenterRoom=(FDroom(aIroom)+FDroom(dIroom))/2
% CenterCold=(FDcold(aIcold)+FDcold(dIcold))/2

[fc,mc]=interp2sizeVSM(Fcold,Mcold,10001);
[fr,mr]=interp2sizeVSM(Froom,Mroom,10001);
% figure;
% hold on
% plot(fr,(1./(mr-mean(mr))),fc,(1./(mc-mean(mc))));
% legend('300k','25k');
% title('inverted magentizationloops');
% hold off;

% [~,aIroom]=max(Droom);
% [~,dIroom]=max(-Droom);
% [~,aIcold]=max(Dcold);
% [~,dIcold]=max(-Dcold);
% 
% CenterRoom=(FDroom(aIroom)+FDroom(dIroom))/2
% CenterCold=(FDcold(aIcold)+FDcold(dIcold))/2

% figure;
% plot(fr,-abs(mr))


[fr,mr]=interp2sizeVSM(fr,mr,201);
%%linear component
dy=-.00005;

linearPart=tanh(fr/2000)/70;
%noise
noise=rand(size(mr))/8;

figure('Name','Signal Manipulation')
subplot(2,2,1)
hold on;
title('noise')
plot(fr,noise);
xlabel('applied field');
hold off;

subplot(2,2,2)
hold on;
title('linear-ish correction');
plot(fr, linearPart);
xlabel('applied field');
hold off;

subplot(2,2,3)
hold on;
title('noise+linear+signal')
plot(fr,mr+linearPart+noise);
xlabel('applied field');
hold off;

subplot(2,2,4)
hold on;
plot(fr,-abs(mr+noise+linearPart))
title('negative absolute value of noise added hysteresis loop')
xlabel('applied field');
hold off;

figure('Name','Comparison with APS data')
subplot(2,1,1);
hold on;
number=38;
makePlot(number);
title(['Scan ',num2str(number)]);
hold off;

subplot(2,1,2);
hold on;
manip=-abs(mr+noise+linearPart);
plot(fr,manip)
title('manipulated signal');
hold off;






