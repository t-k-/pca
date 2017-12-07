function show_me_img(img_matrix)
	figure;
	each_row = 6;
	for i = 1: each_row
		img = reshape(img_matrix(:, i), [28 28]);
		subplot(1, each_row, i)
		%img'
		%imshow(img', [0, 256]);
		imshow(img', [min(img(:)), max(img(:))]);
		hold on;
	end
end
