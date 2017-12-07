function [P,s,X_new,per,m] = pca_digit_all(num)

[img, lbl] = read_hw;
%img = img';

img1 = img(:,1:num);

[P, s, X_new,per] = pca(img1,2);
m = mean(img1,2);

pause;

I = reshape(m,28,28);
I = I';
imshow(I,[min(m),max(m)]);

pause;

for i=1:5
    
    subplot(1,5,i);
    
    I = reshape(P(:,i),28,28);
    I = I';
    imshow(I,[min(P(:,i)),max(P(:,i))]);
end
    
    
