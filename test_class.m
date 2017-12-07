clear

test(2, 1)
test(2, 2)

%for nclass = [2, 3, 10]
%	for nexample = [1, 2]
%		test(nclass, nexample)
%	end
%end

function test(nclass, nexample)
	[trainlabel, traindata] = readtrain(nclass, nexample);
	testdata = readtest(nclass, nexample);
	[y, W] = linear_regression(traindata, @expansion, trainlabel, testdata);
	W
	[err, idx_wrong] = classerr_per(y, nclass, nexample);
	[nclass, nexample, err]
end

function Z = expansion(X)
	[h, w] = size(X);
	Z = vertcat(ones(1, w), X);
end
