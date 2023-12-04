
 
% AB channel AGGD fitting feature (AGGD+ kurtosis+ skewness) =6 with the L-component moment statistics feature
%(6*5) + (3*4) = 42 dimensions
% feature   I1_fit I2fit I3_fit I4_fit I5_fit L component moments A component moments B component moments
% dimension 6      6     6      6      6      4                   4                   4
function [final_feature] = CIELab_AB_Feature_extraction(I)
%% Feature extraction
I1_AGGD = [];  I2_AGGD = [];I3_AGGD = []; I4_AGGD = []; I5_AGGD = [];
moment = []; 
shifts = [ 0 1; 1 0; 1 1; -1 1];
%% Color Space Conversion
labim=rgb2lab(I);
ima = double(labim(:,:,2)); %LAB2
imb = double(labim(:,:,3));%LAB3
%% moment statistics
vector = ColorMoments(I);
moment = [moment;vector];
moment = abs(moment);

%% opponent difference map I1 
I1 = abs(ima-imb);
k_num = 0.01;
C1 = (k_num*255)^2;
window = fspecial('gaussian',7,7/6);
window = window/sum(sum(window));
mu            = filter2(window, I1, 'same');
mu_sq         = mu.*mu;
sigma         = sqrt(abs(filter2(window, I1.*I1, 'same') - mu_sq));
structdis     = (I1-mu)./(sigma+C1);
I1_skewness=skewness(structdis(:));
I1_kurtosis=kurtosis(structdis(:)); 
% AGGD fit
structdis = mapminmax(structdis(:),0,1);
[alpha, leftstd, rightstd]  = estimateaggdparam(structdis);
const                    =(sqrt(gamma(1/alpha))/sqrt(gamma(3/alpha)));
meanparam                =(rightstd-leftstd)*(gamma(2/alpha)/gamma(1/alpha))*const;
I1_AGGD = [I1_AGGD;alpha,meanparam,leftstd^2,rightstd^2,I1_skewness ,I1_kurtosis];
%% saturation map I2
I2 = sqrt(ima.*ima+imb.*imb);

shifted_s = circshift(I2, shifts(1,:));
diff_s = I2 - shifted_s;
diff_s = diff_s(2:end-1,2:end-1); 
diff_s = diff_s(:);

I2_skewness=skewness(diff_s);
I2_kurtosis=kurtosis(diff_s); 
% AGGD fit
[alpha, leftstd, rightstd]  = estimateaggdparam(diff_s);
const                    =(sqrt(gamma(1/alpha))/sqrt(gamma(3/alpha)));
meanparam                =(rightstd-leftstd)*(gamma(2/alpha)/gamma(1/alpha))*const;
I2_AGGD = [I2_AGGD;alpha meanparam leftstd^2 rightstd^2  I2_skewness I2_kurtosis ];
clear diff_s paramEsts                   

%% opponent angle map I3
I3 = atan(ima./(imb+0.0000001));

shifted_h = circshift(I3, shifts(1,:));
diff_h = I3 - shifted_h;
diff_h = diff_h(2:end-1,2:end-1); diff_h = diff_h(:);
I3_skewness=skewness(diff_h);
I3_kurtosis=kurtosis(diff_h); 
% AGGD fit
[alpha, leftstd, rightstd]  = estimateaggdparam(diff_h);
const                    =(sqrt(gamma(1/alpha))/sqrt(gamma(3/alpha)));
meanparam                =(rightstd-leftstd)*(gamma(2/alpha)/gamma(1/alpha))*const;
I3_AGGD = [I3_AGGD;alpha meanparam leftstd^2 rightstd^2  I3_skewness I3_kurtosis];
clear diff_h paramEsts

%% opponent derivation angle maps I4 and I5
[ima_x,ima_y]=gradient(ima);
[imb_x,imb_y]=gradient(imb);
I4 = atan(ima_x./(imb_y+0.0000001));
shifted_oax = circshift(I4, shifts(1,:));
diff_oax = I4 - shifted_oax;
diff_oax = diff_oax(2:end-1,2:end-1); diff_oax = diff_oax(:);

I4_skewness=skewness(diff_oax);
I4_kurtosis=kurtosis(diff_oax); 

[alpha, leftstd, rightstd]  = estimateaggdparam(diff_oax);
const                    =(sqrt(gamma(1/alpha))/sqrt(gamma(3/alpha)));
meanparam                =(rightstd-leftstd)*(gamma(2/alpha)/gamma(1/alpha))*const;
I4_AGGD = [I4_AGGD;alpha meanparam leftstd^2 rightstd^2  I4_skewness I4_kurtosis];
clear diff_oax paramEsts

I5 = atan(ima_y./(imb_y+0.0000001));
shifted_oay = circshift(I5, shifts(1,:));
diff_oay = I5 - shifted_oay;
diff_oay = diff_oay(2:end-1,2:end-1); diff_oay = diff_oay(:);
[alpha, leftstd, rightstd]  = estimateaggdparam(diff_oay);

I5_skewness=skewness(diff_oay);
I5_kurtosis=kurtosis(diff_oay); 

const                    =(sqrt(gamma(1/alpha))/sqrt(gamma(3/alpha)));
meanparam                =(rightstd-leftstd)*(gamma(2/alpha)/gamma(1/alpha))*const;
I5_AGGD = [I5_AGGD;alpha meanparam leftstd^2 rightstd^2   I5_skewness I5_kurtosis];
clear diff_oay paramEsts
%% combine feature
final_feature = [I1_AGGD,I2_AGGD,I3_AGGD,I4_AGGD,I5_AGGD,moment];

end

