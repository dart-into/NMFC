
%l hist
% 10


function LuminFeature=CIELab_Lumin_FeatureCompute(im)


I_L=im(:);
Step=(100-0)/9;


[h,bins]=hist(I_L(:),[0:Step:100]);
LuminFeature=h/size(I_L,1);
end

