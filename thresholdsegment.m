function [imo] = thresholdsegment(im1)

T1 =multithresh(im1,2);
[row col] = size(im1);
imo = zeros(row, col);

im2=im1;

for i = 1 : row
    for j = 1 : col
        if im1(i, j) > T1(2)
            imo(i, j) = 1;
        end
    end
end