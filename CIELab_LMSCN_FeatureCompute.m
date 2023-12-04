
%L������MSCNͼ �Լ���MSCN�������²���ͼ�� AGGD�����̬��AGGD4 +_���+ƫ̬�� LBP ���� �����߶�
%���� MSCNLBPֱ��ͼ MSCN��̬ MSCN�²���LBPֱ��ͼ MSCN�²�����̬ 
%ά�� 10            6       10                  6 =32ά
%The MSCN map the L component and downsampling MSCN map 
%LBP hist feature and the AGGD fitted morphology (AGGD4 +kurtosis + skewness) 
% Feature:  MSCNLBP hist MSCN morphology MSCN downsampling LBP hist      MSCN downsampling morphology
% dimension 10           6               10                              6 =32 
function feat=CIELab_LMSCN_FeatureCompute(imdist)
scalenum=2;
window = fspecial('gaussian',7,7/6);   
window = window/sum(sum(window)); 
feat = [];
for itr_scale = 1:scalenum 

%MSCNFeature=clbpFeatureCompute( imdist,0.5);
mu            = filter2(window, imdist, 'same'); 
mu_sq         = mu.*mu; 
sigma         = sqrt(abs(filter2(window, imdist.*imdist, 'same') - mu_sq));
structdis     = (imdist-mu)./(sigma+1); 
%-------

%% 
MSCNFeature=clbpFeatureCompute(structdis,0.5);
nss_skewness=skewness(structdis(:));
nss_kurtosis=kurtosis(structdis(:)); 
[alpha, leftstd, rightstd]  = estimateaggdparam(structdis(:)); 

const                    =(sqrt(gamma(1/alpha))/sqrt(gamma(3/alpha)));
meanparam                =(rightstd-leftstd)*(gamma(2/alpha)/gamma(1/alpha))*const;
feat= [  feat MSCNFeature  alpha,meanparam,leftstd^2,rightstd^2 nss_skewness nss_kurtosis ]; 

imdist                   = imresize(imdist,0.5); 

end

end