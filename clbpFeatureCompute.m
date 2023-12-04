% lbp hist
function [ CLBP_S] = clbpFeatureCompute( im,rvalue)

im               = double(im);  
R=rvalue;
P=8;
patternMappingriu2=getmapping(P,'riu2');
[CLBP_S,CLBP_M,CLBP_C] = clbp(im,R,P,patternMappingriu2,'nh');

end

