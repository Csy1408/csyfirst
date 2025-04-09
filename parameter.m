% 读取图像
img1 = imread('D:\Tensor\benchmark_release(lsm)\parameter\Iws\Iws9.png');
img2 = imread('D:\Tensor\benchmark_release(lsm)\parameter\Iws\Iws1.png');
img3 = imread('D:\Tensor\benchmark_release(lsm)\parameter\Iws\Iws7.png');
img4 = imread('D:\Tensor\benchmark_release(lsm)\parameter\Iws\Iws12.png');
img5 = imread('D:\Tensor\benchmark_release(lsm)\parameter\It\It1.png');
img6 = imread('D:\Tensor\benchmark_release(lsm)\parameter\It\It4.png');
img7 = imread('D:\Tensor\benchmark_release(lsm)\parameter\It\It9.png');
img8 = imread('D:\Tensor\benchmark_release(lsm)\parameter\It\It11.png');
img9 = imread('D:\Tensor\benchmark_release(lsm)\parameter\H\H9.png');
img10 = imread('D:\Tensor\benchmark_release(lsm)\parameter\H\H1.png');
img11= imread('D:\Tensor\benchmark_release(lsm)\parameter\H\H4.png');
img12= imread('D:\Tensor\benchmark_release(lsm)\parameter\H\H12.png');
img13= imread('D:\Tensor\benchmark_release(lsm)\parameter\a\a4.png');
img14 =imread('D:\Tensor\benchmark_release(lsm)\parameter\a\a7.png');
img15 = imread('D:\Tensor\benchmark_release(lsm)\parameter\a\a12.png');
img16= imread('D:\Tensor\benchmark_release(lsm)\parameter\a\a11.png');

% 创建紧凑的2x2子图布局
figure;
tiledlayout(4,4, 'TileSpacing', 'tight', 'Padding', 'tight');

% 显示每个图像并保持原始宽高比
nexttile;
imshow(img1);
axis image;

nexttile;
imshow(img2);
axis image;

nexttile;
imshow(img3);
axis image;

nexttile;
imshow(img4);
axis image;

nexttile;
imshow(img5);
axis image;

nexttile;
imshow(img6);
axis image;

nexttile;
imshow(img7);
axis image;

nexttile;
imshow(img8);
axis image;

nexttile;
imshow(img9);
axis image;

nexttile;
imshow(img10);
axis image;

nexttile;
imshow(img11);
axis image;

nexttile;
imshow(img12);
axis image;

nexttile;
imshow(img13);
axis image;

nexttile;
imshow(img14);
axis image;

nexttile;
imshow(img15);
axis image;

nexttile;
imshow(img16);
axis image;

