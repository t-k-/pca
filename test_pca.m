clear
X0 = [
1 2 3 3 4
7 9 8 3 3
6 7 5 3 5
]

[img_matrix, labels] = read_hw;

method = 'eig';
%method = 'svd';

%%%
% Example 0
%%%
%[Y, k, meanX, P, Sigma, recX] = pca(X0, 0.9, 'eig')
%[Y, k, meanX, P, Sigma, recX] = pca(X0, 0.9, 'svd')
%[Y, k, meanX, P, Sigma, recX] = pca(X0, 0.9, 'xxx')

%%%
% Example 1
%%%
%fours = select_label_data(img_matrix, labels, 4);
%show_me_img(fours);
%
%[Y, k, meanX, P, Sigma, recX] = pca(fours, 0.56, method);
%k
%[Y, k, meanX, P, Sigma, recX] = pca(fours, 0.9, method);
%k
%show_me_img(meanX);

%scaled_P = 128 + P * 128;
%show_me_img(scaled_P);
%show_me_img(recX);

%%%
% Example 2
%%%
[Y, k, meanX, P, Sigma, recX] = pca(img_matrix, 0.56, method);
k
[Y, k, meanX, P, Sigma, recX] = pca(img_matrix, 0.9, method);
k
show_me_img(img_matrix);
show_me_img(meanX);

scaled_P = 128 + P * 128;
show_me_img(scaled_P);
show_me_img(recX);
