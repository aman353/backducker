clear
close all
clc

im=imread('DSCF0646.jpg');
%im=imread('DSCF0648.jpg');
%im=imread('DSCF0680.jpg');
subplot(2,2,1);imshow(im);
im_g=im(:,:,2);
subplot(2,2,2);imshow(im_g);
im_g=histeq(im_g);
%fun = @(x) max(x(:)); 
%im_g = nlfilter(im_g,[5 5],fun);

BW=imbinarize(im_g);
subplot(2,2,3),imshow(BW);
CC=bwconncomp(BW);
count=zeros(1,CC.NumObjects);
for i=1:CC.NumObjects
    count(i)=numel(CC.PixelIdxList{i});
end
%figure,stem(count);
win=5;
vec=[zeros(1,(win-1)/2) count zeros(1,(win-1)/2)];
count_modified=zeros(1,numel(count));
for i=1:numel(count)
    count_modified(i)=min(vec(i:i+win-1));
end
mx=max(count_modified);
BWW=BW;
weed_count=0;
for i=1:CC.NumObjects
    if(numel(CC.PixelIdxList{i})>mx)
        BWW(CC.PixelIdxList{i})=0;
    else
        weed_count=weed_count+1;
    end
end
subplot(2,2,4);imshow(BWW);

disp(['Weed count is ::' num2str(weed_count)]);

figure,imshow(im);
figure,imshow(BWW);