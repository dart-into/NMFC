%concatenate feature
%32+10+42=84
function [  Feature ] = NMFC_FeatureCompute( im)
     
  
     ABFeature = CIELab_AB_Feature_extraction(im);  
   
     imLAB=rgb2lab(im);
     I_L=double(imLAB(:,:,1));
     
     LuminFeature=CIELab_Lumin_FeatureCompute(I_L);
     MSCNFeature=CIELab_LMSCN_FeatureCompute(I_L);
     Feature=[ABFeature LuminFeature MSCNFeature ];   
end

