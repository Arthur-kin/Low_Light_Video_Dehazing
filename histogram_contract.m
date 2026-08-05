clear; close all; clc;


A = imread('black.png'); 
B = imread('hazed.png');


G_low = rgb2gray(A);       % 低光源轉灰階
invert_G = 255 - G_low;    % 低光源負片處理 [cite: 35]
G_haze = rgb2gray(B);      % 有霧影像轉灰階

figure('Name', '低光源負片 vs 有霧影像直方圖比較', 'NumberTitle', 'off');

subplot(2,2,1);
imshow(invert_G);
title('低光源影像之負片 (Inverted)');

subplot(2,2,2);
imhist(invert_G);
grid on;
title('負片直方圖');
xlabel('強度值 (Intensity)');
ylabel('像素數量 (Count)');

subplot(2,2,3);
imshow(G_haze);
title('原始有霧影像 (Hazed Image)');

subplot(2,2,4);
imhist(G_haze);
grid on;
title('霧影像直方圖');
xlabel('強度值 (Intensity)');
ylabel('像素數量 (Count)');
