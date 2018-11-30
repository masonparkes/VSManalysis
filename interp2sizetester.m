%interp2sizeTester
close all;
dataCold=csvread("COPDIRMN_FC_25K.csv",1,0);%gets the whole file
dataRoom=csvread("COPDIRMN_FC_300K_00005.csv",1,0);
Fcold=dataCold(:,14);
Froom=dataRoom(:,14);
Mcold=dataCold(:,21);
Mroom=dataRoom(:,21);

vals=11:10:1000;
%results=zeros(size(vals));

for n=vals
    [f,m]=interp2size(Froom,Mroom,n);
    size(m)
    plot(Froom,Mroom,f,m);
    title(n)
    legend('raw','interpolated')
    pause
end