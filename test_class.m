clear
for nclass = [2, 3, 10]
	for nexample = [1, 2]
		[trainlabel, traindata] = readtrain(nclass, nexample);
		testdata = readtest(nclass, nexample);
		y = linear_regression(traindata, trainlabel, testdata);
		[err, idx_wrong] = classerr_per(y, nclass, nexample);
		[nclass, nexample, err]
	end
end
