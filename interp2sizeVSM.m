function [ interpolatedField,interpolatedMagnetization ] = interp2sizeVSM( field,magnetization,newSize )
%Takes any magnetization (or voltage) and field and gives you a new field
%and magentization that are the newSize long NEW SIZE HAS TO BE ODD. 
%It assumes that the feild
%starts high, descends to the minimum value, and returns to the starting
%field value.
if(mod(newSize,2)~=1)
    ME=MEexception('newSize has to be odd');
    throw(ME);
end
[~,middleindex]=min(field);
step=2*(max(field)-min(field))/newSize;
newDescendingField=max(field):-step:min(field);
newAscendingField=min(field)+step:step:max(field);
newDescendingMagnetization=interp1(field(1:middleindex),magnetization(1:middleindex),newDescendingField,'linear');
newAscendingMagnetization=interp1(field(middleindex:end),magnetization(middleindex:end),newAscendingField,'linear');
interpolatedMagnetization=[newDescendingMagnetization,newAscendingMagnetization];
interpolatedField=[newDescendingField,newAscendingField];

end

