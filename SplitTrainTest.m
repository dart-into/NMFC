%%
%����ļ��ǻ���ѵ��������Լ��� ������� �������Train��TestImageCell �����ŵ���ԭͼ���id �������id����Ӧ
%��ʧ��ͼ����8��2 ���ֳ��� 
%���浽 
%save('SAUD_Fourtrain_matrixCell.mat','SAUD_Fourtrain_matrixCell');
%save('SAUD_Fourtrain_labelCell.mat','SAUD_Fourtrain_labelCell');
%save('SAUD_Fourtest_matrixCell.mat','SAUD_Fourtest_matrixCell');
%save('SAUD_Fourtest_labelCell.mat','SAUD_Fourtest_labelCell');
%���ĸ��ļ����� �ֱ����������ǩ

% The file is a random split between the training and the test set. It's randomly generated. Train and TestImageCell contain the id of the original image that will correspond to this id
% of the distorted image is divided according to 8:2
% save to
%save('SAUD_Fourtrain_matrixCell.mat','SAUD_Fourtrain_matrixCell');
%save('SAUD_Fourtrain_labelCell.mat','SAUD_Fourtrain_labelCell');
%save('SAUD_Fourtest_matrixCell.mat','SAUD_Fourtest_matrixCell');
%save('SAUD_Fourtest_labelCell.mat','SAUD_Fourtest_labelCell');
%The four files contain features and labels

%% ---------------------------------------------------------------
%���ݼ��ָ� ����˼·�������ѡ��ԭͼ20�� ѡȡ���Ӧ��ʧ��ͼ�� ����ѵ������4:1 ��
load SAUD_MOS
load SAUD_NMFC_Feature

load SAUD_refNo
SAUD_dis_Feature=[SAUD_NMFC_Feature] ;



      
%-----------------
SumNumber=50;
for SplitNum=1:SumNumber
TestNum=0;
dataNum=randperm(100); %�ļ����������

dataNumCell{SplitNum,1}=dataNum;
ForSearchDisNumber=[];
TestImageNumberVector=[];%ҲҪ��� Ҫ�������һ�μ��� Ҳ��Ӱ����
%������dis������Ϊÿ��ͼƬ��Ӧ��ʧ�治ͬ ���������ж� ���˾Ͳ������
TestImageNumberVector=dataNum(:,1:20);  
TrainImageNumberVector=dataNum(:,21:100);
TestImageNumberCell{SplitNum,1}=TestImageNumberVector';
TrainImageNumberCell{SplitNum,1}=TrainImageNumberVector';

 %������A���浽��ǰ�ļ����е��ļ�
TestLinenum=1;%TestLine�綨
TrainLinenum=1;%TestLine�綨
TestLine=[]; %dis�в��Լ�������
TrainLine=[];%dis��ѵ����������
%���ѭ���ǽ�ѵ���������Ի���dis�ļ�����ռ�ڼ���ֱ����ȡ����
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
%��ȡ��ѵ���������Լ� ע��ÿ��ѭ����Ҫ���� ���������ۻ�������
SAUD_Fourtrain_matrix=[];
SAUD_Fourtrain_label=[];
SAUD_Fourtest_matrix=[];
SAUD_Fourtest_label=[];

%ѵ���� ����������ȡ 
for i=1:size(TrainLine,2)
    SAUD_Fourtrain_matrix(i,:) = SAUD_dis_Feature(TrainLine(i),:);
    SAUD_Fourtrain_label(i,:) = SAUD_MOS(TrainLine(i),:);
    
end
%���Լ�
for i=1:size(TestLine,2)
    SAUD_Fourtest_matrix(i,:) = SAUD_dis_Feature(TestLine(i),:);
    SAUD_Fourtest_label(i,:) = SAUD_MOS(TestLine(i),:);
    
end

%%���浽cell
SAUD_Fourtrain_matrixCell{SplitNum,1}=SAUD_Fourtrain_matrix;
SAUD_Fourtrain_labelCell{SplitNum,1}=SAUD_Fourtrain_label;
SAUD_Fourtest_matrixCell{SplitNum,1}=SAUD_Fourtest_matrix;
SAUD_Fourtest_labelCell{SplitNum,1}=SAUD_Fourtest_label;
disp(SplitNum)
end
%���������
save('TestImageNumberCell.mat','TestImageNumberCell');
save('TrainImageNumberCell.mat','TrainImageNumberCell')
save('TestLineCell.mat','TestLineCell');
save('TrainLineCell.mat','TrainLineCell');
save('SAUD_Fourtrain_matrixCell.mat','SAUD_Fourtrain_matrixCell');
save('SAUD_Fourtrain_labelCell.mat','SAUD_Fourtrain_labelCell');
save('SAUD_Fourtest_matrixCell.mat','SAUD_Fourtest_matrixCell');
save('SAUD_Fourtest_labelCell.mat','SAUD_Fourtest_labelCell');




