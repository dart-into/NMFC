function [srocc,krocc,plcc,rmse,mae] = verify_performance(mos,predict_mos)

predict_mos = predict_mos(:);
mos = mos(:);

%initialize the parameters used by the nonlinear fitting function
%初始化非线性拟合函数使用的参数
beta(1) = 10;
beta(2) = 0;
beta(3) = mean(predict_mos);
beta(4) = 0.1;
beta(5) = 0.1;

%fitting a curve using the data
%使用数据拟合曲线
[bayta ,ehat,J] = nlinfit(predict_mos,mos,@logistic,beta);
%given a ssim value, predict the correspoing mos (ypre) using the fitted curve
%给定一个ssim值，使用拟合曲线预测对应的mos (ypre)
[ypre ,junk] = nlpredci(@logistic,predict_mos,bayta,ehat,J);
%mae = mean(abs(YReal - YPred));
mae=sum(abs(mos-ypre))/length(mos);
%ypre = predict(logistic,fsimValues,bayta,ehat,J);
rmse = sqrt(sum((ypre - mos).^2) / length(mos));%root meas squared error rmse = sqrt(mean((YPred-YReal).^2));
plcc = corr(mos, ypre, 'type','Pearson'); %pearson linear coefficient
srocc = corr(mos, predict_mos, 'type','spearman');
krocc = corr(mos, predict_mos, 'type','Kendall');
end
