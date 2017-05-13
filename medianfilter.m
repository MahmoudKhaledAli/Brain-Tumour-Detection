function [imo] = medianfilter(im1)
ww=3;
wh=3;
edgex=floor(ww/2) + 1;
edgey=floor(wh/2) + 1;

[h w]=size(im1);
imo = im1;

for i = 2:h-1
    for j = 2:w-1
        c=1;
        colorArr(1) = im1(i+1,j);
        colorArr(2) = im1(i-1,j);
        colorArr(3) = im1(i,j+1);
        colorArr(4) = im1(i,j-1);
        colorArr(5) = im1(i,j);
        colorArr=sort(colorArr);
        imo(i,j)=colorArr(3);
    end
end