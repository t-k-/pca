clear;
train_data = [];
train_label = [];
test_data = [];
test_label = [];
test_cnt = 1;
train_cnt = 1;

for subject = 1:40
	for i = 1:10
		path = strcat('./att_faces/s', num2str(subject), '/', num2str(i), '.pgm');
		img = imresize(imread(path),[32,32]);
		% imshow(img)
		% return;
		if subject > 35 || i > 8
			test_data(:, :, 1, test_cnt) = img;
			test_label = vertcat(test_label, subject);
			test_cnt = test_cnt + 1;
		else
			train_data(:, :, 1, train_cnt) = img;
			train_label = vertcat(train_label, subject);
			train_cnt = train_cnt + 1;
		end
	end
end

layers = [imageInputLayer([32 32 1]);
          convolution2dLayer(12, 25);
		  batchNormalizationLayer();
          reluLayer();
          fullyConnectedLayer(1);
		  regressionLayer()];

options = trainingOptions('sgdm', 'InitialLearnRate',0.001, 'MaxEpochs',15);

rand_idx = randperm(280);
train_data = train_data(:, :, 1, rand_idx);
train_label = train_label(rand_idx);

net = trainNetwork(train_data, train_label, layers, options);
% load('best_recognition_net')

net.Layers

res_train = predict(net, train_data);
res_test = predict(net, test_data);

aaa = horzcat(res_train, train_label);
bbb = horzcat(res_test, test_label);

test_truth = vertcat(zeros(35 * 2, 1), ones(5 * 10, 1));
test_guess = (abs(res_test - test_label) > 10);

horzcat(find(test_label), test_label, test_guess, test_truth)

accuracy = sum(test_guess == test_truth) / numel(test_truth)
