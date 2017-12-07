function [P,s,X_new,per,m] = pca_digit(id)

[img, lbl] = read_hw;
%img = img';

idx = find(lbl==id);
len = length(idx);

img1 = img(:,idx);
[P, s, X_new,per] = pca(img1,2);
m = mean(img1,2);


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

pause;



y = P(:,1:100)*X_new(1:100,:) + m*ones(1,size(img1,2));

for i=1:5
    
    subplot(2,5,i);
    
    I = reshape(y(:,i),28,28);
    I = I';
    imshow(I);%,[min(P(i,:)),max(P(i,:))]);
    
    subplot(2,5,i+5);
    I = reshape(img1(:,i),28,28);
    I = I';
    imshow(I);
    
end

pause;

y = P(:,1:500)*X_new(1:500,:) + m*ones(1,size(img1,2));


for i=1:5
    
    subplot(2,5,i);
    
    I = reshape(y(:,i),28,28);
    I = I';
    imshow(I);%,[min(P(i,:)),max(P(i,:))]);
    
    subplot(2,5,i+5);
    I = reshape(img1(:,i),28,28);
    I = I';
    imshow(I);
    
end
    
    
