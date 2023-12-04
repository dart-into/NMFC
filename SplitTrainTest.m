%%
%这个文件是划分训练集与测试集的 随机划分 随机生成Train与TestImageCell 里面存放的是原图像的id 按照这个id将对应
%的失真图像按照8：2 划分出来 
%保存到 
%save('SAUD_Fourtrain_matrixCell.mat','SAUD_Fourtrain_matrixCell');
%save('SAUD_Fourtrain_labelCell.mat','SAUD_Fourtrain_labelCell');
%save('SAUD_Fourtest_matrixCell.mat','SAUD_Fourtest_matrixCell');
%save('SAUD_Fourtest_labelCell.mat','SAUD_Fourtest_labelCell');
%这四个文件里面 分别是特征与标签

% The file is a random split between the training and the test set. It's randomly generated. Train and TestImageCell contain the id of the original image that will correspond to this id
% of the distorted image is divided according to 8:2
% save to
%save('SAUD_Fourtrain_matrixCell.mat','SAUD_Fourtrain_matrixCell');
%save('SAUD_Fourtrain_labelCell.mat','SAUD_Fourtrain_labelCell');
%save('SAUD_Fourtest_matrixCell.mat','SAUD_Fourtest_matrixCell');
%save('SAUD_Fourtest_labelCell.mat','SAUD_Fourtest_labelCell');
%The four files contain features and labels

%% ---------------------------------------------------------------
%数据集分割 具体思路是先随机选出原图20张 选取其对应的失真图像 这样训练测试4:1 了
load SAUD_MOS
load SAUD_NMFC_Feature

load SAUD_refNo
SAUD_dis_Feature=[SAUD_NMFC_Feature] ;



      
%-----------------
SumNumber=50;
for SplitNum=1:SumNumber
TestNum=0;
dataNum=randperm(100); %文件的随机矩阵

dataNumCell{SplitNum,1}=dataNum;
ForSearchDisNumber=[];
TestImageNumberVector=[];%也要清空 要不会从上一次继续 也会影响结果
%这里是dis里面因为每张图片对应的失真不同 所以做个判断 够了就不用添加
TestImageNumberVector=dataNum(:,1:20);  
TrainImageNumberVector=dataNum(:,21:100);
TestImageNumberCell{SplitNum,1}=TestImageNumberVector';
TrainImageNumberCell{SplitNum,1}=TrainImageNumberVector';

 %将变量A保存到当前文件夹中的文件
TestLinenum=1;%TestLine界定
TrainLinenum=1;%TestLine界定
TestLine=[]; %dis中测试集的行数
TrainLine=[];%dis中训练集的行数
%这个循环是将训练集跟测试机在dis文件夹中占第几行直接提取出来
for j=1:1000
    if(ismember(SAUD_refNo(j),TestImageNumberVector)==1)
        TestLine(TestLinenum)=j;
        TestLinenum=TestLinenum+1;
  
   
    end
end
for j=1:1000
    if(ismember(SAUD_refNo(j),TrainImageNumberVector)==1)
       
  
    
        TrainLine(TrainLinenum)=j;
        TrainLinenum=TrainLinenum+1;
    end
end
TestLineCell{SplitNum,1}=TestLine;
TrainLineCell{SplitNum,1}=TrainLine;

%---------------------------------------------------------------------------
%提取出训练集跟测试集 注意每次循环都要重置 否则会产生累积的问题
SAUD_Fourtrain_matrix=[];
SAUD_Fourtrain_label=[];
SAUD_Fourtest_matrix=[];
SAUD_Fourtest_label=[];

%训练集 根据行数提取 
for i=1:size(TrainLine,2)
    SAUD_Fourtrain_matrix(i,:) = SAUD_dis_Feature(TrainLine(i),:);
    SAUD_Fourtrain_label(i,:) = SAUD_MOS(TrainLine(i),:);
    
end
%测试集
for i=1:size(TestLine,2)
    SAUD_Fourtest_matrix(i,:) = SAUD_dis_Feature(TestLine(i),:);
    SAUD_Fourtest_label(i,:) = SAUD_MOS(TestLine(i),:);
    
end

%%保存到cell
SAUD_Fourtrain_matrixCell{SplitNum,1}=SAUD_Fourtrain_matrix;
SAUD_Fourtrain_labelCell{SplitNum,1}=SAUD_Fourtrain_label;
SAUD_Fourtest_matrixCell{SplitNum,1}=SAUD_Fourtest_matrix;
SAUD_Fourtest_labelCell{SplitNum,1}=SAUD_Fourtest_label;
disp(SplitNum)
end
%将结果保存
save('TestImageNumberCell.mat','TestImageNumberCell');
save('TrainImageNumberCell.mat','TrainImageNumberCell')
save('TestLineCell.mat','TestLineCell');
save('TrainLineCell.mat','TrainLineCell');
save('SAUD_Fourtrain_matrixCell.mat','SAUD_Fourtrain_matrixCell');
save('SAUD_Fourtrain_labelCell.mat','SAUD_Fourtrain_labelCell');
save('SAUD_Fourtest_matrixCell.mat','SAUD_Fourtest_matrixCell');
save('SAUD_Fourtest_labelCell.mat','SAUD_Fourtest_labelCell');




