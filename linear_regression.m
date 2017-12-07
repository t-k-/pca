clear

Y = [
1 0 0 0
0 1 0 0
0 0 1 0
0 0 0 1
];

X = [
0 0 1 1
0 1 0 1
];

Z = expansion(X)

W = Y * Z' * inv(Z * Z');

W * expansion([0 0]')
W * expansion([0 1]')
W * expansion([1 0]')
W * expansion([1 1]')

function Z = expansion(X)
	Z = vertcat(X, X(1,:) .* X(2,:));
end
