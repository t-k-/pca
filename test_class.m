clear
nclass = 2;
nexample = 1;

[trainlabel, traindata] = readtrain(nclass, nexample);
testdata = readtest(nclass, nexample);
%y = linear_regression(X, [1 2 3 4], X)
