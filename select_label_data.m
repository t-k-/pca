function [sel_matrix, sel_labels] = disp_fours(img_matrix, labels, select_num)
	idx = find(labels == select_num);
	sel_matrix = img_matrix(:,idx);
	sel_labels = labels(idx);
end
