function recX = pca_recover(X, meanX, P, k)
	selectP = P(:, 1:k);
	Y = selectP' * (X - meanX);
	recX = selectP * Y;
end
