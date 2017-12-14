clear;
train_data = [];
train_label = [];
test_data = [];
test_label = [];
test_cnt = 1;
train_cnt = 1;

for i=0:399
    path = strcat('./non-face-data/non-face-image', num2str(i), '.png');
	img = mat2gray(uint8(imread(path)));
    if i>279
		test_data(:, :, 1, test_cnt) = img(:,:,1);
		test_label = horzcat(test_label, 0);
        test_cnt = test_cnt + 1;
    else  
		train_data(:, :, 1, train_cnt) = img(:,:,1);
		train_label = horzcat(train_label, 0);
		train_cnt = train_cnt + 1;
    end
end
for subject = 1:40
	for i = 1:10
		path = strcat('./att_faces/s', num2str(subject), '/', num2str(i), '.pgm');
		img = imresize(imread(path),[32,32]);
		if subject > 35 || i > 8
			test_data(:, :, 1, test_cnt) = img;
			test_label = horzcat(test_label, 1);
			test_cnt = test_cnt + 1;
		else
			train_data(:, :, 1, train_cnt) = img;
			train_label = horzcat(train_label, 1);
			train_cnt = train_cnt + 1;
		end
	end
end

layers = [imageInputLayer([32 32 1]);
          convolution2dLayer(5, 32);
		  batchNormalizationLayer();
          reluLayer();
          maxPooling2dLayer(2,'Stride', 2);

%           convolution2dLayer(5, 32);
% 		  batchNormalizationLayer();
%           reluLayer();
%           maxPooling2dLayer(2,'Stride', 2);

          fullyConnectedLayer(64);
          reluLayer();
          fullyConnectedLayer(2);
          softmaxLayer();

          classificationLayer()];

options = trainingOptions('sgdm');
t = categorical(train_label);

net = trainNetwork(train_data, t, layers, options);

net.Layers

% size(test_data(:, :, 1, 20))
% imshow(test_data(:, :, 1, 20))

res_test = classify(net, test_data);
s = categorical(test_label);

accuracy = sum(res_test' == s) / numel(res_test)

% save('best_net', 'net')

% Display what is falsely recognized to what
wrong_idx = find(res_test' ~= s)
