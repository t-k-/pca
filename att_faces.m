clear;

dataset = [];

for subject = [1:40]
	for i = [1:10]
		path = strcat('./att_faces/s', num2str(subject), '/', num2str(i), '.pgm');
		img = double(imread(path));
		img_vec = reshape(img, [numel(img), 1]);
		dataset = horzcat(dataset, img_vec);
	end
end

%size(dataset)

method = 'eig';
[Y, k, meanX, P, Sigma, recX, sigmaPercents] = pca(dataset, 0.56, method);

% disp_face(dataset)
% disp_face(meanX)
% disp_face(P(:, 100));
% disp_face(recX)
