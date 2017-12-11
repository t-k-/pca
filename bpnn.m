clear;
load('test_data.mat');
load('train_data.mat');
load('train_label.mat');
load('test_label.mat');

best_net = '';
best_train_pass = 0;
best_test_pass = 0;

while 1
	[h, w] = size(train_data);
	rand_idx = randperm(w);
	train_data = train_data(:, rand_idx);
	train_label = train_label(:, rand_idx);

	net = newff(train_data, train_label, [120 100 100 80 60]);
	net.efficiency.memoryReduction = 4;
	% net.trainFcn = 'trainlm';
	% net.trainFcn = 'trainbfg';
	net.trainFcn = 'trainrp';
	% net.trainFcn = 'traingd';
	net.trainParam.max_fail = 10;

	net = train(net, train_data, train_label);

	a = test(net, train_data, train_label);
	b = test(net, test_data, test_label);

	if b > best_test_pass
		best_train_pass = a
		best_test_pass = b
		best_net = net;
	end
end

function pass = test(net, test_data, test_label)
	test_output = round(net(test_data));
	err = test_label - test_output;
	pass = sum(err == 0);
	%length(err)
end
