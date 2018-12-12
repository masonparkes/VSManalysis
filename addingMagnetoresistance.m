close all; clear;
dataCold=csvread("COPDIRMN_FC_25K.csv",1,0);%gets the whole file
%dataRoom=csvread("COPDIRMN_FC_300K_00005.csv",1,0);
Fcold=dataCold(:,14);
%Froom=dataRoom(:,14);
Mcold=dataCold(:,21);
%Mroom=dataRoom(:,21);

Mcold=Mcold./max(Mcold);
[fc,mc]=interp2size(Fcold,Mcold,100001);

% Ok, so the issue is that we have a weird shape nd we want a hysteresis loop
% What are the possible issues?
% 1) there is mangeto resistance adding to our sample
%     What would happen if we looked at adding something like magnetoresistance
%     to a hysteresis loop?
%I'll try to simulate something like that.
%some magneto resistance appears to be gaussian around H=0, This may be
%Giant Magnetoresistance
mr=normpdf(fc,0,1000);
mr=mr./max(mr);
figure;
subplot(2,1,1);
plot(fc,mr,fc,mc);
subplot(2,1,2);
signal=mc-mr*.5;
plot(fc,signal);

%others appear to cause a linear increase while ascending before dropping 
%near saturation, and then doing a similar thing while descending, again
%dropping near the other saturation point
[~,mid]=min(fc);
desF=fc(1:mid);
ascF=fc(mid+1:end);
n=1;
ascMR=zeros(size(ascF));
ascMR(1)=0;
while(ascF(n)<3000)
    ascMR(n+1)=ascMR(n)+1;
    n=n+1;
end
for m=n:size(ascF,2)-1
    ascMR(m+1)=ascMR(m)-3;
end
desMR=zeros(size(desF));
desMR(1)=0;
n=1;
while(desF(n)>-3000)
    desMR(n+1)=desMR(n)+1;
    n=n+1;
end
for m=n:size(desF,2)-1
    desMR(m+1)=desMR(m)-3;
end
figure;
subplot(2,2,1)
plot(desF,desMR,ascF,ascMR)
legend('descending','ascending')
subplot(2,2,2)
MR=[desMR,ascMR];
MR=MR./max(MR);
for n=1:1000
    MR=smooth(MR);
end
FC=[desF,ascF];
[~,mr]=interp2size(FC,MR,100001);
plot(fc,mr);
subplot(2,2,3);
plot(fc,mc);
subplot(2,2,4);;
plot(fc,mc+mr);



