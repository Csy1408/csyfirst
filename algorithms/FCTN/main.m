clc;
clear;
close all;

addpath(genpath(pwd));%将当前文件夹及其子文件夹加入到工作路径

ext_name='.bmp';
patchSize =70;  % 40 50 60 70 80   70
slideStep =70;  
timeSize =15;  % 5 10 15 20   15
%prior_algo_name ='mySTLC';  %'mySTLC','TLC','STLCF','STLDM','HoG_LCM'

datas = {'sequence1','sequence4','sequence7','sequence9'};
for i = 1:length(datas)
data = datas{i};
img_path = ['D:\Tensor\benchmark_release(lsm)\benchmark_release(lsm)\dataset\data\',data,'\'];
des_path = ['D:\Tensor\benchmark_release(lsm)\benchmark_release(lsm)\all_result\',data,'/STPA_FCTN_e5/'];
time_path = 'D:\Tensor\benchmark_release(lsm)\benchmark_release(lsm)\time_results\';
%prior_result_path=['D:\code\tensor_code\shiyan\comparision\FCTN_prior_2\prior_result\STLDM\sequence',data];

if ~exist(des_path, 'dir')
    mkdir(des_path);
end
 

% --------------------
start_idx = 1;
ImageList = dir(fullfile(img_path, '*.bmp'));
len = length(ImageList);

% --------------------
time=0;
i_num = ceil(len/timeSize);
for i=1:i_num
    for j=1:timeSize
        if i>floor(len/timeSize)
            cur_idx = j + len - timeSize + start_idx - 1;
        else
            cur_idx = (i - 1) * timeSize + j + start_idx - 1; 
        end
        
        img = imread( [img_path num2str(cur_idx,'%04d') '.bmp'] );   
        if ndims(img) == 3
            img = rgb2gray(img);
        end
        [m,n]=size(img);
        
       %prior image
       %STPA algorithm
        last_i = i_num;
        last_j = timeSize - 2;
        if (i==1 && j<3)||(i==last_i && j>last_j)
              prior_map=mySLC(img_path,ext_name,cur_idx);
        else
              prior_map=mySTLC(img_path,ext_name,cur_idx);
        end
        %直接读取结果图像
        %prior_map=imread([prior_result_path num2str(cur_idx,'%04d') '.png']);
         
        % 4D tensor
        prior_map=im2double(prior_map);
        img = im2double(img);
        D = gen_patch_ten(img, patchSize, slideStep);  
        prior_3D=gen_patch_ten(prior_map, patchSize, slideStep);  
        img_4D(:,:,j,:)=D;
        prior_4D(:,:,j,:)=prior_3D;
    end
    
    tic
        [tenBack,tenTar] = FCTN(img_4D,prior_4D); %prior weight
        %[tenBack,tenTar] = FCTN(img_4D);%without prior weight
    toc
    time = time + toc;
    
    for j = 1: timeSize
        if i>floor(len/timeSize)
            cur_idx = len +j- timeSize;
        else
            cur_idx = (i-1) * timeSize + j + start_idx - 1; 
        end
        tarImg = res_patch_ten_mean (tenTar(:,:,j,:), img, patchSize, slideStep);
        T = tarImg / (max(tarImg(:)) + eps);
        
        res_path = [des_path, num2str(cur_idx,'%04d'), '.png'];
        imwrite(T, res_path);   
    end

end
    times = 1.0 * time / len ;
    
    txt_path = [time_path, 'STPA-FCTN' , '.txt'];
    fid = fopen(txt_path, 'a');

    time_name = datestr(now, 'yy-mm-dd_HH-MM-SS');
    fprintf(fid, '%s\n', [time_name, ':']);
    disp( num2str(times, '%.4f'));
    fprintf(fid, '%s\n', ['STPA-FCTN in ', data, ' run as ', num2str(times, '%.4f'),'times.']);
    fclose(fid);
end

