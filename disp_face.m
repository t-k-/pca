function disp_face(img_matrix)
	figure;
	each_row = 6;
	for i = 1: each_row
		img = reshape(img_matrix(:, i), [112 92]);
		subplot(1, each_row, i)
		imshow(img, [min(img(:)), max(img(:))]);
		hold on;
	end
end
