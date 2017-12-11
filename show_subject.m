function show_subject(subject)
	path = strcat('./att_faces/s', num2str(subject), '/', num2str(1), '.pgm');
	img = imread(path);
	imshow(img);
end
