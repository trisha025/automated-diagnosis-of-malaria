%% 
warning off
 [FileName,PathName] = uigetfile('*.*','Select the Image');
    [img, map] = imread(fullfile(PathName,FileName));
 org= imread(FileName); %Original image
%hsvImage=rgb2hsv(org);
imshow(org);

%%
h=imfreehand(gca); %drawing outline for the desired figure
position =wait(h);

binaryImage = h.createMask();
% Display the freehand mask.
subplot(2, 2, 2);
imshow(binaryImage);
title('Binary mask of the region');

% Get coordinates of the boundary of the freehand drawn region.
structBoundaries = bwboundaries(binaryImage);
xy=structBoundaries{1}; % Get n by 2 array of x,y coordinates.
x = xy(:, 2);	% Columns.
y = xy(:, 1);	% Rows.
subplot(2, 2, 1); % Plot over original image.
hold on;	% Don't blow away the image.
plot(x, y, 'LineWidth', 2);

burnedImage = org;
burnedImage(binaryImage) = 255;

% Display the image with the mask "burned in."
subplot(2, 2, 3);
imshow(burnedImage);
title('New image with mask burned into image');

% Mask the image and display it.
% Will keep only the part of the image that's inside the mask, zero outside
% mask
maskedImage = org;
maskedImage(~binaryImage) = 0;
subplot(2, 2, 4);
imshow(maskedImage);
title('Masked Image');

%resultImage = maskedImage .* cat(3, binaryImage, binaryImage, binaryImage); 
%figure(); imshow(resultImage)

%% R,G and B channels %%
rchannel=maskedImage(:,:,1); %Red
gchannel=maskedImage(:,:,2); %Green
bchannel=maskedImage(:,:,3); %Blue

%figure();

[rows,columns]=size(rchannel);

%subplot(1,3,1); imshow(rchannel); title('Red');
%subplot(1,3,2); imshow(gchannel); title('Green');
%subplot(1,3,3); imshow(bchannel); title('Blue');

           %%
answer =zeros(10,3);
 counter=1;
for i=1:rows
    for j = 1:columns
        if rchannel(i,j)~=0
            answer(counter,3) = bchannel(i,j);
            answer(counter,2) = gchannel(i,j);
            answer(counter,1) = rchannel(i,j);
            counter = counter+1;
        end
    end
end


