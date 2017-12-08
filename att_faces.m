dataset = [];

for subject = [1:40]
	for i = [1:10]
		path = strcat('./att_faces/s', num2str(subject), '/', num2str(i), '.pgm');
		img = double(imread(path));
		img_vec = reshape(img, [numel(img), 1]);
		dataset = horzcat(dataset, img_vec);
	end
end

%size(dataset)

method = 'eig';

% [Y, k, meanX, P, Sigma, recX, sigmaPercents] = pca(dataset, 0.56, method);
% % k = 8
% [Y, k, meanX, P, Sigma, recX, sigmaPercents] = pca(dataset, 0.70, method);
% % k = 20
% [Y, k, meanX, P, Sigma, recX, sigmaPercents] = pca(dataset, 0.85, method);
% % k = 68
% [Y, k, meanX, P, Sigma, recX, sigmaPercents] = pca(dataset, 0.90, method);
% % k = 111


% figure;
% j = 1;
% all_k = [8, 20, 68, 111];
% for i = all_k
% 	recoverX_i = pca_recover(dataset, meanX, P, i);
% 	disp_face(recoverX_i, length(all_k), j);
% 	title(sprintf('top-4 for k=%d', i));
% 	j = j + 1;
% end


train_dat = []; % 111 by 280
test_dat = [];  % 111 by 120
cnt = 1;
for subject = [1:40]
	for i = [1:10]
		reduced_img_vec = Y(:, cnt); % Y is 111 by n
		if subject > 35 || i > 8
			test_dat = horzcat(test_dat, reduced_img_vec);
		else
			train_dat = horzcat(train_dat, reduced_img_vec);
		end
		cnt = cnt + 1;
	end
end
