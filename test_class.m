clear

% test(2, 1, @affine_expansion)
% test(2, 2, @affine_expansion)

test(3, 1, @affine_expansion)
test(3, 2, @affine_expansion)

test(3, 1, @polynomial2_expansion)
test(3, 2, @polynomial2_expansion)

%for nclass = [2, 3, 10]
%	for nexample = [1, 2]
%	end
%end

function test(nclass, nexample, expansion)
	[trainlabel, traindata] = readtrain(nclass, nexample);
	testdata = readtest(nclass, nexample);
	[y, W] = linear_regression(traindata, expansion, trainlabel, testdata);
	W
	[err, idx_wrong] = classerr_per(y, nclass, nexample);
	[nclass, nexample, err]
end

function Z = affine_expansion(X)
	[h, w] = size(X);
	Z = vertcat(ones(1, w), X);
end

function Z = polynomial2_expansion(X)
	[h, w] = size(X);
	Z = vertcat(ones(1, w), X, X(1,:).^2, X(2,:).^2);
end
