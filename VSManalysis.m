close all;
dataCold=csvread("COPDIRMN_FC_25K.csv",1,0);%gets the whole file
dataRoom=csvread("COPDIRMN_FC_300K_00005.csv",1,0);
Fcold=dataCold(:,14);
Froom=dataRoom(:,14);
Mcold=dataCold(:,21);
Mroom=dataRoom(:,21);
Mroom=Mroom./max(Mroom);
Mcold=Mcold./max(Mcold);
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
Dcold=Dcold./max(Dcold);
figure;
plot(FDcold,Dcold,FDroom,Droom);
legend('25K','300K');
title('First Derivatives');

figure;
plot(Fcold,Mcold,Froom,Mroom,FDcold,Dcold,FDroom,Droom);
title('Overlaid Plots');



