%% =================================================================
% This script performs Non-Convex Tensor Low-Rank Approximation for Infrared Small Target Detection 
% 
% More detail can be found in [1]
% [1] Ting Liu, Jungang Yang, Boyang Li, Chao Xiao, Yang Sun, Yingqian Wang, Wei An.
%     Non-Convex Tensor Low-Rank Approximation for Infrared Small Target Detection .
%
% Created by Ting Liu 
% 11/10/2021
clc;
clear;
close all;

%% setup parameters 
H =10; % tuning forbetter performance
L=3; % tuning forbetter performance
C=10;
p=0.8;
k=100;
%% input data
for seq=1:1
data=[num2str(seq) '\'];
strDir=['D:\code\tensor_code\shiyan\benchmark合集\benchmark_release(wyl)\dataset\data\sequence',data];
%strDir='D:\code\tensor_code\shiyan\benchmark_release(sea))_2\dataset\data\sequence1\';
for i=1:k
    picname=[strDir  num2str(i,'%04d'),'.bmp'];
    I=imread(picname);
    [~, ~, ch]=size(I);
    if ch==3
        I=rgb2gray(I);
    end
    D(:,:,i)=I;
end
        tenD=double(D);
        size_D=size(tenD);
        [n1,n2,n3]=size(tenD);
        T=C*sqrt(n1*n2);
        n_1=max(n1,n2);%n(1)
        n_2=min(n1,n2);%n(2)
        patch_frames=L;%L
        patch_num=n3/patch_frames;
tic
for l=1:patch_num
    for i=1:patch_frames
        X(:,:,i)=tenD(:,:,patch_frames*(l-1)+i);
    end

%% initialization
        mu = 1e-2;
        lambda1=0.005;
        lambda2= H / sqrt((n_1*patch_frames));        
        lambda3=100;%100
        weight=[1,1,1];
        [tenB,tenT,tenN] = ATVSTIPT1LPLS(X, lambda1,lambda2,lambda3, weight,mu,T,p);
        for i=1:patch_frames
            tarImg=tenT(:,:,i);
            a=uint8(tarImg);
            %figure,imshow(a,[]);
            backImg=tenB(:,:,i);b=uint8(backImg);
        end 
end
toc
%%%time_test

    %time_name = datestr(now, 'yy-mm-dd_HH-MM-SS');
    res_base_path='D:\code\tensor_code\shiyan\benchmark_release(sea))_2\time_test_results\';
    txt_path = [res_base_path, 'time_ASTTV_sequence',num2str(seq) , '.txt'];
    fid = fopen(txt_path, 'a');
    times = 1.0 * toc/100 ;
    disp( num2str(times, '%.4f'));
    fprintf(fid, '%s\n', num2str(times, '%.4f'),'times.');
    fclose(fid);
    
end
