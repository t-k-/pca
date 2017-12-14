clear;

% load lettersTrainSet
% class(TTrain)

train_data = [];
train_label = [];
test_data = []; 
test_label = [];

test_cnt = 1;
train_cnt = 1;
for subject = [1:40]
	for i = [1:10]
		path = strcat('./att_faces/s', num2str(subject), '/', num2str(i), '.pgm');
		img = imresize(imread(path), [28, NaN]);
		if subject > 35 || i > 8
			test_data(:, :, 1, test_cnt) = mat2gray(uint8(img));
			test_label = vertcat(test_label, subject);
			test_cnt = test_cnt + 1;
		else
			train_data(:, :, 1, train_cnt) = mat2gray(uint8(img));
			train_label = vertcat(train_label, subject);
			train_cnt = train_cnt + 1;
		end
	end
end

layers = [imageInputLayer([28 23 1]);
          convolution2dLayer(5, 32);
		  batchNormalizationLayer();
          reluLayer();
          maxPooling2dLayer(2,'Stride', 2);
          fullyConnectedLayer(64);
          reluLayer();
          fullyConnectedLayer(35);
          softmaxLayer();
          classificationLayer()];

options = trainingOptions('sgdm');
t = categorical(train_label);

net = trainNetwork(train_data, t, layers, options);
%load('best_net')

net.Layers

% size(test_data(:, :, 1, 20))
% imshow(test_data(:, :, 1, 20))

res_test = classify(net, test_data);
s = categorical(test_label);

first35 = (res_test == s);
first35 = first35(1:35);
accuracy = sum(first35) / numel(first35)

% Display what is falsely recognized to what
% wrong_idx = find(first35 == 0)
% 
% for i = [1: length(wrong_idx)]
% 	guess = double(res_test(wrong_idx(i)));
% 	truth = test_label(wrong_idx(i));
% 	subplot(length(wrong_idx), 2, i * 2 + 0);
% 	show_subject(guess)
% 	subplot(length(wrong_idx), 2, i * 2 - 1);
% 	show_subject(truth)
% 	hold on;
% end
% save('best_net', 'net')
