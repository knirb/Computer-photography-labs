% H = compute_homography(points1, points2)
%
% Method: Determines the mapping H * points1 = points2
% 
% Input:  points1, points2 are of the form (3,n) with 
%         n is the number of points.
%         The points should be normalized for 
%         better performance.
% 
% Output: H 3x3 matrix 
%

function H = compute_homography( points1, points2 )

%-------------------------
% TODO: FILL IN THIS PART
alpha = 0;
beta = 0;
for i = 1:length(points1)
    if ~isnan(points1(1,i)) && ~isnan(points2(1,i))
        xa = points1(1,i);
        xb = points2(1,i);
        ya = points1(2,i);
        yb = points2(2,i);
        alphai = [xb yb 1 0 0 0 -xb*xa -yb*xa -xa];
        betai = [0 0 0 xb yb 1 -xb*ya -yb*ya -ya];
        if alpha == 0
            alpha = alphai;
        else
            alpha = [alpha; alphai];
        end
        if beta == 0
            beta = betai;
        else
            beta = [beta; betai];
        end
    end
end
Q = [alpha; beta];
[U S V]= svd(Q);
h = V(:,end);
H = zeros(3,3);
k = 1;
for i = 1:3
    for j = 1:3
        H(i,j) = h(k);
        k = k+1;
    end
end
end


