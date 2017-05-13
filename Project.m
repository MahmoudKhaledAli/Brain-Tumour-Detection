function [numberofTumours maxDiameter position] = Project(imagename)

orgim = imread(imagename);

im = (orgim);

figure('Name','Original Image');
imshow(im);

%first step
im = rgb2gray(im);

%second step
im = im2double(im).^3;

%third step
im = medianfilter(im);
[row col] = size(im);
%T = multithresh(im,2);
%im(im < T(1)) = T(2);
% mask = ones(row,col);
% mask (im < 20) = 0;
%im = imclearborder(im);
%figure
%imshow(mask,[]);

figure('Name','Scan after preprocessing');
imshow(im,[]);


%fourth step
segmentation = thresholdsegment(uint8(im*255));
% LPF = [1 1 1; 1 1 1; 1 1 1] * (1/9);
% im = imfilter(im,LPF);
% T = multithresh(im,1);
% segmentation = zeros(row,col);
% segmentation(im >= T) = 1;

ratio = 5.2941e-04 * 2;

[row col channel] = size(orgim);

radius = sqrt(ratio*row*col/pi);

figure('Name','Image After Segmentation')
imshow(segmentation,[]);
se = strel('disk',round(double(radius)),0);
segmentation = imerode(segmentation,se);
se = strel('disk', round(double(radius)), 0);
segmentation = imdilate(segmentation,se);
figure('Name','Image after morphological algorithms');
imshow(segmentation,[]);

if max(segmentation) == 0
    position = 'No Tumour Detected';
else
    labels = bwlabel(segmentation);
    numberofTumours = max(max(labels));
    maxDiameter = 0;
    for i = 1:max(max(labels)) + 1
        mask  = zeros(size(labels));
        mask(labels == i) = 1;
        stats = regionprops(mask,'centroid','MajorAxisLength','MinorAxisLength');
        diameter = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
        if diameter > maxDiameter
            maxDiameter = diameter;
            centroidMax = stats.Centroid;
        end
    end

    [r c] = size(segmentation);

    if centroidMax(2) < r/3 & centroidMax(1) > c/2
        position = 'Right Frontal Lobe';
    elseif centroidMax(2) < r/3 & centroidMax(1) < c/2
        position = 'Left Frontal Lobe';
    elseif centroidMax(2) > 3*r/4
        position = 'Cerebellum';
    elseif centroidMax(1) > c/2
        position = 'Right Tomporoccipital Lobe';
    elseif centroidMax(1) < c/2
        position = 'Left Tomporoccipital Lobe';
    end

    maxDiameter = maxDiameter * 15 / r;

end


required_image = (segmentation == 1);

figure('Name','Final output')

[r c] = find(required_image);

imshow(orgim);

hold on;

plot(c,r,'b.');

