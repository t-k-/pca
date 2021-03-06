function [y, W, z] = linear_regression(data, expansion, label, predict_data)
	W = train(data, expansion, label);
	y = predict(predict_data, expansion, W);
	z = predict(data, expansion, W);
end

function W = train(data, expansion, label)
	[h, w] = size(data);
	min_label = min(label(:));
	max_label = max(label(:));
	Y = zeros(max_label - min_label + 1, w);
	for i = [1: w]
		Y(label(i), i) = 1;
	end
	Z = expansion(data);
	W = Y * Z' * inv(Z * Z');
end

function y = predict(data, expansion, W)
	[h, w] = size(data);
	y = zeros(1, w);
	for i = [1: w]
		x = data(:, i);
		indicator = W * expansion(x);
		[val, idx] = max(indicator);
		y(i) = idx;
	end
end

% function Z = expansion(X)
% 	Z = X;
% 	%Z = vertcat(X, X(1,:) .* X(2,:));
% end

% X = [
% 0 0 1 1
% 0 1 0 1
% ];
% 
% y = linear_regression(X, [1 2 3 4], X)
