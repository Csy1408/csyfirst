% mySTLC('../../dataset/data13/', '.bmp', 10);

function Smap = mySTLC(file_path, ext_name, img_idx)
% tic
SLC = mySLC3(file_path, ext_name, img_idx);
TLC = myTLC(file_path, ext_name, img_idx);
Smap = SLC .* TLC;
Smap = ( Smap - min(Smap(:)) ) / (  max(Smap(:)) -  min(Smap(:)) );
%Smap = Smap/ (  max(Smap(:)) -  min(Smap(:)) );
imshow(Smap);
% path_cur = fullfile([file_path, num2str(img_idx,'%04d'), ext_name]);
% img_cur = imread(path_cur); 
% if ndims( img_cur ) == 3
%     img_cur = double( rgb2gray(img_cur) );
% end
% 
 %subplot(221),imshow(img_cur,[]),title('原图');
 %subplot(222),imshow(SLC),title('空间显著图');
 %subplot(223),imshow(TLC),title('时间显著图');
 %subplot(224),imshow(Smap),title('最终显著图');

% toc
end

