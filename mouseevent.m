function mouse_keypress_test()
clc
close all
clear all

expDir = 'H:/nana/data/fcn4s-500-33cases_MICCAI2009_CropCentroidIamgesbl3_128';
inputDir = 'H:/nana/data/fcn4s-500-33cases_MICCAI2009_128bilinear256_dealedge/filling_result';
imdbPath = fullfile(expDir, 'imdb.mat') ;

len = length(inputDir);
                                
% set(gcf,'WindowButtonDownFcn',@ButttonDownFcn);
set(gcf,'windowkeypressfcn',@keypressfcn,'userdata',[inputDir,imdbPath,len,1]);
set(gcf,'windowkeyreleasefcn',@keyreleasefcn);

end

% function ButttonDownFcn(src,event)
%         i = 1;
%         if strcmp(get(gcf,'SelectionType'),'alt')% 此时即为右键
%             if i == numel(val)
%             end
%         elseif strcmp(get(gcf,'SelectionType'),'normal')% 此时即为左键
%             imshow('SCD0000001_0804.png');
%         end
%         imId = val(i) ;
%         name = imdb.images.name{imId} ;
%         display(['comparison: ' name]);
%         inputPath = fullfile(inputDir, [name '.png']) ;
%         prefix = name(1:10);
%         suffix = name(12:15);
%         index = find(strcmp(X , prefix));
%         folder = X{index,2};
% end

function keypressfcn(src,event)
    str = (get(gcf,'userdata'));
    index = double(str(length(str) - 1));
    inputDir = str(1:index);
    imdbPath = str(index+1:length(str)-2);
    imdb = load(imdbPath) ;
    val = find(imdb.images.set == 2 & imdb.images.segmentation) ;
    i = double(str(length(str)));
    name = imdb.images.name{val(i)};
    display(['comparison: ' name]);
    subplot(1,2,2);
    imshow(fullfile(inputDir, [name  '.png']) )
    title(strcat(name,'.png'));
    if double(get(gcf,'CurrentCharacter')) == 30  %键盘的↑
        i = i - 1;
        if i < 1
            %信息对话框
            msgbox('这是第一张图片','提示','warn');
            return;
        end
    elseif double(get(gcf,'CurrentCharacter')) == 31 %键盘的↓
        i = i + 1;
        if i > numel(val)
            %信息对话框  
            msgbox('这是最后一张图片','提示','warn');  
            return;
        end
    end
    imId = val(i) ;
    name = imdb.images.name{imId} ;
    display(['comparison: ' name]);
    inputPath = fullfile(inputDir, [name '.png']) ;
    subplot(1,2,2);
    imshow(inputPath);
    title(strcat(name,'.png'));
    set(gcf,'userdata',[inputDir,imdbPath,index,i]);
    
    pointDir = 'H:/nana/data/groundtruth';
    Imagedata = 'H:/nana/data/33cases_MICCAI2009/Images'
    X=cell(30,2);
    X{1, 1}='SCD0000401'; X{1, 2}='SC-HF-I-05';
    X{2, 1}='SCD0000501'; X{2, 2}='SC-HF-I-06';
    X{3, 1}='SCD0000601'; X{3, 2}='SC-HF-I-07';
    X{4, 1}='SCD0000701'; X{4, 2}='SC-HF-I-08';
    X{5, 1}='SCD0001501'; X{5, 2}='SC-HF-NI-07';
    X{6, 1}='SCD0001601'; X{6, 2}='SC-HF-NI-11';
    X{7, 1}='SCD0002101'; X{7, 2}='SC-HF-NI-31';
    X{8, 1}='SCD0002201'; X{8, 2}='SC-HF-NI-33';
    X{9, 1}='SCD0002701'; X{9, 2}='SC-HYP-06';
    X{10,1}='SCD0002801'; X{10,2}='SC-HYP-07';
    X{11,1}='SCD0002901'; X{11,2}='SC-HYP-08';
    X{12,1}='SCD0003401'; X{12,2}='SC-HYP-37';
    X{13,1}='SCD0003901'; X{13,2}='SC-N-05';
    X{14,1}='SCD0004001'; X{14,2}='SC-N-06';
    X{15,1}='SCD0004101'; X{15,2}='SC-N-07';
    
    prefix = name(1:10);
    suffix = name(12:15);
    value = find(strcmp(X , prefix));
    folder = X{value,2};
    inputPathPrefix = fullfile(pointDir,folder,'contours-manual','IRCCI-expert') ;
    
    inputPath1 = fullfile(inputPathPrefix,['IM-0001-' suffix '-icontour-manual.txt']);
    inputPath2 = fullfile(inputPathPrefix,['IM-0001-' suffix '-ocontour-manual.txt']);
    
    display(inputPath1);
    display(inputPath2);
    data_i = dlmread(inputPath1);
    data_o = dlmread(inputPath2);
    hold all;
    plot(data_i(:,1),data_i(:,2),'g-',data_o(:,1),data_o(:,2),'r-');
    display(fullfile(Imagedata, [name '.dcm']));
    I = dicomread(fullfile(Imagedata, [name '.dcm']));
    subplot(1,2,1);
    imshow(I, 'DisplayRange',[]);
    title(strcat(name,'.dcm'));
end

function keyreleasefcn(src,event)

end