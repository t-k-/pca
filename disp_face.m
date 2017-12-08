function disp_face(img_matrix, total_rows, row)
	each_row = 4;
	for i = 1: each_row
		img = reshape(img_matrix(:, i), [112 92]);
		subplot(total_rows, each_row, (row - 1) * each_row + i)
		imshow(img, [min(img(:)), max(img(:))]);
		hold on;
	end
end
