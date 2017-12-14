%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% see if the image contains a face or not %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
train_data = [];
test_data = [];
test_cnt = 1;
train_cnt = 1;
dataset = [];
% create labels for both face data and non-face data
% 1 for non-faces; 2 for faces
test_label_non = uint8(ones(120,1));
test_label_face = uint8(2*ones(120,1));
train_label_non = uint8(ones(280,1));
train_label_face = uint8(2*ones(280,1));
train_label = vertcat(train_label_non,train_label_face);
test_label = vertcat(test_label_non,test_label_face);

% read non-face dataset
for i=0:399
    path_non_face = strcat('./non-face-data/non-face-image', num2str(i), '.png');
    img = imread(path_non_face);
    img = double(img(:,:,1));
    img = img/255;
    img_vec = reshape(img, [numel(img), 1]);
    dataset = horzcat(dataset, img_vec); 
end
% read face dataset 
for subject = 1:40
    for i = 1:10
		path = strcat('./att_faces/s', num2str(subject), '/', num2str(i), '.pgm');
		img = double(imresize(imread(path),[32,32]));
        img = img/255;
		img_vec = reshape(img, [numel(img), 1]);
		dataset = horzcat(dataset, img_vec);
    end
end


% method for sovling pca
method = 'eig';
% Dimensionality Reduction 
[Y, k, meanX, P, Sigma, recX, sigmaPercents] = pca(dataset, 0.90, method);

% assign data to training set and test set
cnt = 1;
for i=1:400
    reduced_img_vec = Y(:,cnt);
    if i>280
        %test_data(:,:,1,test_cnt) = img; %for CNN use
        test_data = horzcat(test_data, reduced_img_vec);
        test_cnt = test_cnt + 1;
    else  
        %train_data(:,:,1,train_cnt) = img; %CNN
        reduced_img_vec = Y(:,i);
        train_data = horzcat(train_data, reduced_img_vec);
        train_cnt = train_cnt + 1;
    end
    cnt = cnt + 1;
end
for subject = 1:40
	for i = 1:10
		reduced_img_vec = Y(:, cnt); % Y is 111 by n
		if subject > 35 || i > 8
			test_data = horzcat(test_data, reduced_img_vec);
			%test_label = horzcat(test_label, subject);
		else
			train_data = horzcat(train_data, reduced_img_vec);
			%train_label = horzcat(train_label, subject);
		end
		cnt = cnt + 1;
	end
end


%%%%
% train, predict and judge accuracy using affine_expansion
%%%%
[y, W] = linear_regression(train_data, @affine_expansion, train_label, test_data);
accuracy = sum(test_label' == y) / length(test_label)

%%%%
% train, predict and judge accuracy using polynomial2_expansion
%%%%
[y, W] = linear_regression(train_data, @polynomial2_expansion, train_label, test_data);
accuracy = sum(test_label' == y) / length(test_label)

%%%%
% train, predict and judge accuracy using polynomial3_expansion
%%%%
[y, W] = linear_regression(train_data, @polynomial3_expansion, train_label, test_data);
accuracy = sum(test_label' == y) / length(test_label)

%%%%
% train, predict and judge accuracy using polynomial4_expansion
%%%%
[y, W] = linear_regression(train_data, @polynomial4_expansion, train_label, test_data);
accuracy = sum(test_label' == y) / length(test_label)

function Z = affine_expansion(X)
	[h, w] = size(X);
	Z = vertcat(ones(1, w), X);
end

function Z = polynomial2_expansion(X)
	[h, w] = size(X);
	Z = vertcat(ones(1, w), X, X.^2);
end
function Z = polynomial3_expansion(X)
	[h, w] = size(X);
	Z = vertcat(ones(1, w), X, X.^2, X.^3);
end

function Z = polynomial4_expansion(X)
	[h, w] = size(X);
	Z = vertcat(ones(1, w), X, X.^2, X.^3, X.^4);
end