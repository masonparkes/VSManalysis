%interp2sizeTester
close all;
dataCold=csvread("COPDIRMN_FC_25K.csv",1,0);%gets the whole file
dataRoom=csvread("COPDIRMN_FC_300K_00005.csv",1,0);
Fcold=dataCold(:,14);
Froom=dataRoom(:,14);
Mcold=dataCold(:,21);
Mroom=dataRoom(:,21);

vals=11:10:10000;
results=zeros(size(vals));

for n=1:size(vals,2)
    [f,m]=interp2size(Froom,Mroom,vals(n));
    results(n)=size(m,2);
end
results==vals