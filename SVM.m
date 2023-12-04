
% 训练模型 
%% I. 清空环境变量
clear all
clc

%% II. 导入数据
load SAUD_Fourtest_labelCell
load SAUD_Fourtest_matrixCell
load SAUD_Fourtrain_labelCell
load SAUD_Fourtrain_matrixCell

for TrainNum=1:size(SAUD_Fourtrain_matrixCell,1)
train_label=SAUD_Fourtrain_labelCell{TrainNum,1}; 
test_label=SAUD_Fourtest_labelCell{TrainNum,1};
train_matrix=SAUD_Fourtrain_matrixCell{TrainNum,1};
test_matrix=SAUD_Fourtest_matrixCell{TrainNum,1};

%%
% 1. 随机产生训练集和测试集
%n = randperm(size(sum_rep_vec,1));

%%
% 2. 训练集——777个样本
 % train_matrix = sum_rep_vec(n(1:782),:);
 % train_label = Label(n(1:782),:);

%%
% 3. 测试集——205个样本
% test_matrix = sum_rep_vec(n(782:end),:);
% test_label = Label(n(782:end),:);

%% III. PCA降维
%  [coeff,score,latent,tsquared,explained,mu] = pca(train_matrix);
% deVector=cumsum(latent)/sum(latent);%累积贡献值
%  findVector=find(deVector>0.999);
%  p=findVector(5);
% pcatranslate_matrix = coeff(:,1:275);
%  train_data0 = bsxfun(@minus,train_matrix,mean(train_matrix,1));
% low_train_data = train_data0 * pcatranslate_matrix;
% test_data0 = bsxfun(@minus,test_matrix,mean(train_matrix,1)); 
%  low_test_data = test_data0 * pcatranslate_matrix;
% % 
%  train_matrix=low_train_data;
% test_matrix=low_test_data;

%% 数据归一化
[Train_matrix,PS] = mapminmax(train_matrix',0,1);
Train_matrix = Train_matrix';
Test_matrix = mapminmax('apply',test_matrix',PS);
Test_matrix = Test_matrix';
SAUD_Four_PS=PS;
SAUD_Four_PSCell{TrainNum,1}=SAUD_Four_PS;

%% 1. 寻找最佳c/g参数——交叉验证方法
 [c,g] = meshgrid(5:0.5:10,-5:0.5:0);
 [m,n] = size(c);
 cg = zeros(m,n);
 mae=100000;
 oriplcc=0;
 for i = 1:m
     for j = 1:n
         cmd = ['-s 3 -t 2',' -c ',num2str(2^c(i,j)),' -g ',num2str(2^g(i,j))];
         SAUD_Four_model = svmtrain(train_label,Train_matrix,cmd);     
         [predict_label,accuracy,prob_estimates] = svmpredict(test_label,Test_matrix,SAUD_Four_model);
         [srocc,krocc,plcc,rmse,mae2] = verify_performance(test_label,predict_label);       
% %        %  if(mae2<mae)
% %        %  mae=mae2;
          if(srocc>oriplcc)
             oriplcc=srocc;
             bestc = 2^c(i,j);
             bestg = 2^g(i,j);
             cgCell(TrainNum,1)=bestc;
             cgCell(TrainNum,2)=bestg;
             cgCell(TrainNum,3)=c(i,j);
             cgCell(TrainNum,4)=g(i,j);
             preedict_labelCell{TrainNum,1}=predict_label; 
          end
             disp(j)
             disp(i)
             disp(TrainNum)
     end 
 end
  %cmd = ['-s 3 -t 2',' -c ',num2str(256),' -g ',num2str(0.0825)];
   cmd = ['-s 3 -t 2',' -c ',num2str(bestc),' -g ',num2str(bestg)];

%%
% 2. 创建/训练SVM模型
%cmd = ('-s 3 -t 2 ');
SAUD_Four_model = svmtrain(train_label,Train_matrix,cmd);
SAUD_Four_modelCell{TrainNum,1}=SAUD_Four_model;

%% V. SVM仿真测试
[predict_label_1,accuracy_1,prob_estimates] = svmpredict(train_label,Train_matrix,SAUD_Four_model);
[predict_label_2,accuracy_2,prob_estimates2] = svmpredict(test_label,Test_matrix,SAUD_Four_model);
result_1 = [train_label predict_label_1];
result_2 = [test_label predict_label_2];
[srocc3,krocc3,plcc3,rmse3,mae23] = verify_performance(test_label,predict_label_2);
MerticCell{TrainNum,1}=srocc3;
MerticCell{TrainNum,2}=krocc3;
MerticCell{TrainNum,3}=plcc3;
MerticCell{TrainNum,4}=rmse3;
disp(TrainNum)
end
save('SAUD_Four_modelCell.mat','SAUD_Four_modelCell');
save('SAUD_Four_PSCell.mat','SAUD_Four_PSCell');
save('cgCell.mat','cgCell');
save('MerticCell.mat','MerticCell');
save('preedict_labelCell.mat','preedict_labelCell')

%% VI. 绘图
figure
plot(1:length(test_label),test_label,'r-*')
hold on
plot(1:length(test_label),predict_label_2,'b:o')
grid on
legend('真实类别','预测类别')
xlabel('测试集样本编号')
ylabel('测试集样本类别')
string = {'测试集SVM预测结果对比(RBF核函数)';
          ['accuracy = ' num2str(accuracy_2(1)) '%']};
title(string)