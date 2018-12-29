function [ ] = kmeans1(imname)

I=imread(imname); %reading original image

figure(1); imshow(imname); title('Original Image');

hsv=rgb2hsv(I); %conversion in hsv color space

%%%extractin out each color space seperately%%%
hChannel = hsv(:, :, 1); 
sChannel = hsv(:, :, 2); 
vChannel = hsv(:, :, 3); 


%%intensifying each channel%%

vChannel_1=imadjust(vChannel); 
hsvImage2_v = cat(3, hChannel, sChannel, vChannel_1);
rgbImage2_v = hsv2rgb(hsvImage2_v);

hChannel_1=imadjust(hChannel);
hsvImage2_h = cat(3, hChannel_1, sChannel, vChannel);
rgbImage2_h = hsv2rgb(hsvImage2_h);

sChannel_1=imadjust(sChannel);
hsvImage2_s = cat(3, hChannel, sChannel_1, vChannel);
rgbImage2_s = hsv2rgb(hsvImage2_s);

%figure(2); 
%subplot(1,3,1); imshow(rgbImage2_h); title('Hue Channel');
%subplot(1,3,2); imshow(rgbImage2_s); title('Saturation Channel');
%subplot(1,3,3); imshow(rgbImage2_v); title('Value channel');

%%removing noise%%
med_s=medfilt2(sChannel_1, [5 5]);
med_h=medfilt2(hChannel_1, [5 5]);
med_v=medfilt2(vChannel_1, [5 5]);

%figure(3);
%subplot(1,3,1); imshow(med_h); title('Median Filter - Hue');
%subplot(1,3,2); imshow(med_s); title('Median Filter - Saturation');
%subplot(1,3,3); imshow(med_v); title('Median Filter - Value');

%%applying kmeans for segmentation%%
[ch nh]= kmeans(med_h(:), 5);
ph = reshape(ch, size(med_h));

[cs ns]= kmeans(med_s(:), 5);
ps = reshape(cs, size(med_s));

[cv nv]= kmeans(med_v(:), 5);
pv = reshape(cv, size(med_v));

%index images%
figure(4); 
subplot(1,3,1); imshow(ph, []); title('Index Image - Hue'); 
subplot(1,3,2); imshow(ps, []); title('Index Image - Saturation');
subplot(1,3,3); imshow(pv, []); title('Index Image - Value');

%%showing each segmentation%%
figure(5);
subplot(3,3,1); imshow(ph==1, []); title('1 - Hue');
subplot(3,3,2); imshow(ph==2, []); title('2 - Hue');
subplot(3,3,3); imshow(ph==3, []); title('3 - Hue');
subplot(3,3,4); imshow(ph==4, []); title('4 - Hue');
subplot(3,3,5); imshow(ph==5, []); title('5 - Hue');

figure(6);
subplot(3,3,1); imshow(ps==1, []); title('1 - Saturation');
subplot(3,3,2); imshow(ps==2, []); title('2 - Saturation');
subplot(3,3,3); imshow(ps==3, []); title('3 - Saturation');
subplot(3,3,4); imshow(ps==4, []); title('4 - Saturation');
subplot(3,3,5); imshow(ps==5, []); title('5 - Saturation');

prompt={'Enter Cluster Number'};
title1='Input';
dims=[1 35];
answer = inputdlg(prompt,title1,dims)
   

figure(7);
subplot(3,3,1); imshow(pv==1, []); title('1 - Value');
subplot(3,3,2); imshow(pv==2, []); title('2 - Value');
subplot(3,3,3); imshow(pv==3, []); title('3 - Value');
subplot(3,3,4); imshow(pv==4, []); title('4 - Value');
subplot(3,3,5); imshow(pv==5, []); title('5 - Value');
end
