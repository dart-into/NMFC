

im=imread('2_Water-net.png');
final_feature=NMFC_FeatureCompute(im);

%final_feature = mapminmax(final_feature',0,1);
%final_feature=final_feature';
PS=SAUD_Four_PSCell{1,1};
Test_matrix = mapminmax('apply',final_feature',PS);
Test_matrix=Test_matrix';

NMFC_model=SAUD_Four_modelCell{1,1};
[predict_label,accuracy,prob_estimates] = svmpredict(1,Test_matrix,NMFC_model);
