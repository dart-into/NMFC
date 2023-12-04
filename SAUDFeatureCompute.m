

%% SAUD
load  sub_bt_scores
inpath = 'yourpath\Benchmark\Enhanced';

for i=1:size(sub_bt_scores,1)
  
       disname=sub_bt_scores{i,1};

        fname = strcat(inpath,'\',disname);
        temp = char(fname);
        im = imread(temp);
        SAUD_NMFC_Feature(i,:)= NMFC_FeatureCompute(im);

disp(i)   
end





%% UIED
%FilePath =  'C:\Users\26403\Desktop\UIEDÊý¾Ý¼¯\UIED\UIED_dis\';  %image path
%fileExt = '*.bmp';  
%find all images path
%files = dir(fullfile(FilePath,fileExt)); 
%files_name={files.name};
%files_name =sort_nat(files_name);%sort
%filelength = size(files,1);

%for i=1:filelength;
%  fileName = strcat(FilePath,files_name{i}); 
%  im = imread(fileName);

%UIED_Myfuntion_Feature(i,:)=MyFeatureCompute(im);

 
%   disp(i)
%end




