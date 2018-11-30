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

figure;
plot(Froom,abs(1./Mroom),Fcold,abs(1./Mcold));
legend('300k','25k');
title('inverted magentizationloops');

%%interpolating the original data
[~,middleindex]=min(Froom);
step=1;
newDesFroom=Froom(1):-step:Froom(middleindex);
newAscFroom=Froom(middleindex):step:Froom(end);
newDesMroom=interp1(Froom(1:middleindex),Mroom(1:middleindex),newDesFroom,'linear');
newAscMroom=interp1(Froom(middleindex:end),Mroom(middleindex:end),newAscFroom,'linear');
newMroom=[newDesMroom,newAscMroom];
newFroom=[newDesFroom,newAscFroom];
figure;
hold on;
plot(Froom,Mroom);
plot(newFroom,newMroom);
hold off;






