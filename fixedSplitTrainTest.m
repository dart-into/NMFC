%%
% This file is divided into the training and test set according to the TestCell and TrainCell already divided. It stores the image id in order to control the variables
% Lets different algorithms work on the same training and test set


%% ---------------------------------------------------------------
%The specific idea is to randomly select 20 original images and select their corresponding distorted 
%images so that the training and testing are 4:1
load SAUD_MOS

load SAUD_NMFC_Feature

%%

SAUD_dis_Feature=[SAUD_NMFC_Feature] ;

load TestLineCell
load TrainLineCell

%-----------------
SumNumber=50;
for SplitNum=1:SumNumber
TestLine=TestLineCell{SplitNum,1};
TrainLine=TrainLineCell{SplitNum,1};
%---------------------------------------------------------------------------

SAUD_Fourtrain_matrix=[];
SAUD_Fourtrain_label=[];
SAUD_Fourtest_matrix=[];
SAUD_Fourtest_label=[];

%train
for i=1:size(TrainLine,2)
    SAUD_Fourtrain_matrix(i,:) = SAUD_dis_Feature(TrainLine(i),:);
    SAUD_Fourtrain_label(i,:) = SAUD_MOS(TrainLine(i),:);
    
end
%test
for i=1:size(TestLine,2)
    SAUD_Fourtest_matrix(i,:) = SAUD_dis_Feature(TestLine(i),:);
    SAUD_Fourtest_label(i,:) = SAUD_MOS(TestLine(i),:);
    
end

%%save to cell
SAUD_Fourtrain_matrixCell{SplitNum,1}=SAUD_Fourtrain_matrix;
SAUD_Fourtrain_labelCell{SplitNum,1}=SAUD_Fourtrain_label;
SAUD_Fourtest_matrixCell{SplitNum,1}=SAUD_Fourtest_matrix;
SAUD_Fourtest_labelCell{SplitNum,1}=SAUD_Fourtest_label;
disp(SplitNum)
end
%save result

save('SAUD_Fourtrain_matrixCell.mat','SAUD_Fourtrain_matrixCell');
save('SAUD_Fourtrain_labelCell.mat','SAUD_Fourtrain_labelCell');
save('SAUD_Fourtest_matrixCell.mat','SAUD_Fourtest_matrixCell');
save('SAUD_Fourtest_labelCell.mat','SAUD_Fourtest_labelCell');






