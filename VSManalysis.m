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
plot(Fcold,Mcold,Froom,Mroom)
legend('25K','300K');
title('VSM data');


Dcold=diff(Mcold);
Droom=diff(Mroom);

FDcold=zeros(size(Dcold));
for n=1:size(FDcold,1)
   FDcold(n)=(Fcold(n)+Fcold(n+1))/2; 
end
FDroom=zeros(size(Droom));
for n=1:size(FDroom,1)
   FDroom(n)=(Froom(n)+Froom(n+1))/2; 
end
Droom=Droom./max(Droom);
Dcold=smooth(Dcold);
Dcold=Dcold./max(Dcold);

figure;
plot(FDcold,Dcold,FDroom,Droom);
legend('25K','300K');
title('First Derivatives');

figure;
plot(Fcold,Mcold,Froom,Mroom,FDcold,Dcold,FDroom,Droom);
legend('25k','300k','25k derivative','300k derivative');
title('Overlaid Plots');

[~,aIroom]=max(Droom);
[~,dIroom]=max(-Droom);
[~,aIcold]=max(Dcold);
[~,dIcold]=max(-Dcold);

CenterRoom=(FDroom(aIroom)+FDroom(dIroom))/2
CenterCold=(FDcold(aIcold)+FDcold(dIcold))/2


[fc,mc]=interp2size(Fcold,Mcold,10001);
[fr,mr]=interp2size(Froom,Mroom,10001);
figure;
plot(fr,(1./(mr-mean(mr))),fc,(1./(mc-mean(mc))));
legend('300k','25k');
title('inverted magentizationloops');
[~,aIroom]=max(Droom);
[~,dIroom]=max(-Droom);
[~,aIcold]=max(Dcold);
[~,dIcold]=max(-Dcold);

CenterRoom=(FDroom(aIroom)+FDroom(dIroom))/2
CenterCold=(FDcold(aIcold)+FDcold(dIcold))/2










