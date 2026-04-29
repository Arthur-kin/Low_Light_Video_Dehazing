clear; close all; clc;

A = imread('black1_1.png');
A = im2double(A);
A_origin = im2double(A);
[h, w, ~] = size(A);
A = 1 - A;

patch_size = 15;
pad  = floor(patch_size/2);%半徑為7的
nu   = 0.95;
t0   = 0.1;

% dark channel
dark = zeros(h,w);
for y = 1:h
    for x = 1:w
        %確保不會超過邊界
        y1 = max(1, y-pad); y2 = min(h, y+pad);
        x1 = max(1, x-pad); x2 = min(w, x+pad);
        patch = A(y1:y2, x1:x2, :);
        dark(y,x) = min(patch(:));%dark的公式
    end
end
B = dark;

% atmospheric light A 
n_pixels   = h * w;
num_bright = floor(n_pixels * 0.001);%尋找0.1%有幾個pixel

%對灰階進行排序 找出最大值的index
[~, idx_sorted] = sort(dark(:),'descend');
indices = idx_sorted(1:num_bright);

A_reshaped = reshape(A, [], 3);
A_air = mean(A_reshaped(indices, :), 1);   % 1x3

%transmission t(x)
t = zeros(h,w);
for y = 1:h
    for x = 1:w
        %跟上面一樣邊界問題
        y1 = max(1, y-pad); y2 = min(h, y+pad);
        x1 = max(1, x-pad); x2 = min(w, x+pad);
        patch = A(y1:y2, x1:x2, :);

        % I^c / A^c
        patchR = patch(:,:,1) / A_air(1);
        patchG = patch(:,:,2) / A_air(2);
        patchB = patch(:,:,3) / A_air(3);

        minVal = min([patchR(:); patchG(:); patchB(:)]);
        t(y,x) = 1 - nu * minVal;%t的公式
    end
end
% --- 插入引導濾波優化透射率 ---
% 使用原始影像的灰階圖作為引導影像 (Guidance Image)
gray_A = rgb2gray(A); 

%Guilded Filter

% 進行引導濾波：t 是你原本有塊狀感的透射率，gray_A 是引導
% 'NeighborhoodSize' 建議與你原本的 patch_size 接近
% 'DegreeOfSmoothing' (epsilon) 常用值為 0.001 或 0.0001
t_smooth = imguidedfilter(t, gray_A, 'NeighborhoodSize', [8 8], 'DegreeOfSmoothing', 0.01);

% 使用優化後的 t_smooth 進行還原
t = max(t_smooth, t0); 
% ... 後續還原 C 的步驟不變 ...

% J(x)
C = zeros(size(A));
t_clamped = max(t, t0);
for c = 1:3
    C(:,:,c) = (A(:,:,c) - A_air(c)) ./ t_clamped + A_air(c);%重建去霧景象J的公式
end
C = min(max(C,0),1);

C = 1 - C;

subplot(1,4,1); imshow(A_origin); title('Original black Image (A)');
subplot(1,4,2); imshow(A); title('negative Image (A)');
subplot(1,4,3); imshow(B); title('Dark Channel (B)');
subplot(1,4,4); imshow(C); title('dehazed black Image (C)');

imwrite(B, 'DarkChannel.png');
imwrite(C, 'ASM_result.png');
