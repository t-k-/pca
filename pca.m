function [Y, k, meanX0, P, Sigma, recX] = pca(X0, threshold, method)

[p, n] = size(X0);

meanX0 = (ones(n, 1) * mean(X0'))';
X = X0 - meanX0;

[V, D] = eig(X * X');

[sortedSigma, Index] = sort(diag(D), 'descend');

P = V(:, Index);
Sigma = diag(sortedSigma);

% Y = P' * X;
% P * P' is unitary

totalSigma = sum(sortedSigma);
curSigmaSum = 0;
for k = [1: length(sortedSigma)]
	curSigmaSum = curSigmaSum + sortedSigma(k);
	if (curSigmaSum / totalSigma) >= threshold
		break
	end
end

selectP = P(:, 1:k); % p by k
Y = selectP' * X; % Y is k by n
recX = selectP * Y;
