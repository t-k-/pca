clear;
load('test_data.mat');
load('train_data.mat');
load('train_label.mat');
load('test_label.mat');

while 1
	net = newff(train_data, train_label, [120 100 100 80 60]);
	net.efficiency.memoryReduction = 4;
	% net.trainFcn = 'trainlm';
	% net.trainFcn = 'trainbfg';
	net.trainFcn = 'trainrp';
	% net.trainFcn = 'traingd';
	net.trainParam.max_fail = 10;

	net = train(net, train_data, train_label);

	test(net, train_data, train_label);
	test(net, test_data, test_label)

end

function test(net, test_data, test_label)
	test_output = round(net(test_data));
	err = test_label - test_output;
	sum(err == 0)
	length(err)
end
