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

%%%%
% Dimension reduction
%%%%
[Y, k, meanX, P, Sigma, recX, sigmaPercents] = pca(dataset, 0.90, method);
% k = 111

%%%%
% top-4 recover images for different k
%%%%
figure;
j = 1;
all_k = [8, 20, 68, 111];
for i = all_k
	recoverX_i = pca_recover(dataset, meanX, P, i);
	disp_face(recoverX_i, length(all_k), j);
	title(sprintf('top-4 for k=%d', i));
	j = j + 1;
end


%%%%
% extract training data and test data
%%%%
train_data = [];  % 111 by 280
train_label = [];
test_data = [];   % 111 by 120
test_label = [];

cnt = 1;
for subject = [1:40]
	for i = [1:10]
		reduced_img_vec = Y(:, cnt); % Y is 111 by n
		if subject > 35 || i > 8
			test_data = horzcat(test_data, reduced_img_vec);
			test_label = horzcat(test_label, subject);
		else
			train_data = horzcat(train_data, reduced_img_vec);
			train_label = horzcat(train_label, subject);
		end
		cnt = cnt + 1;
	end
end

%%%%
% train, predict and judge accuracy using affine_expansion
%%%%
[y, W] = linear_regression(train_data, @affine_expansion, train_label, test_data);
err = test_label - y;
err_rate = sum(err == 0) / length(err)

%%%%
% train, predict and judge accuracy using polynomial2_expansion
%%%%
[y, W] = linear_regression(train_data, @polynomial2_expansion, train_label, test_data);
err = test_label - y;
err_rate = sum(err == 0) / length(err)

function Z = affine_expansion(X)
	[h, w] = size(X);
	Z = vertcat(ones(1, w), X);
end

function Z = polynomial2_expansion(X)
	[h, w] = size(X);
	Z = vertcat(ones(1, w), X, X(1,:).^2, X(2,:).^2);
end
