clear;
clc;
close all;

OutputDir = 'data/fcn4s-500-33cases_128/filling_result/';
Outputpath = 'data/fcn4s-500-33cases_128';
file_path =  'data/fcn4s-500-33cases_128/processed_result/'
img_path_list = dir(strcat(file_path,'*.png'));%��ȡ���ļ���������png��ʽ��ͼ��  
img_num = length(img_path_list);%��ȡͼ��������   

if ~exist(fullfile(Outputpath, 'filling_result')) 
   mkdir(fullfile(Outputpath, 'filling_result'));
end
    
 for j = 1:img_num %��һ��ȡͼ��  
     image_name = img_path_list(j).name;% ͼ����  
     [I,map] = imread(strcat(file_path,image_name)); 
     [m,n] = size(I);
     I = I(1:2:m,1:2:n);
%      b = padarray(I, [64 64]); 
     a = padarray(I, [63 63]); %��A����Χ��չ63��0
     b = padarray(a,[2 2],'replicate','post');
     pathfile = fullfile(OutputDir,image_name); 
     imshow(b,map);
     imwrite(b,map,pathfile,'png');
 end