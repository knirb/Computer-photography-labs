% Method:   compute all normalization matrices.  
%           It is: point_norm = norm_matrix * point. The norm_points 
%           have centroid 0 and average distance = sqrt(2))
% 
%           Let N be the number of points and C the number of cameras.
%
% Input:    points2d is a 3xNxC array. Stores un-normalized homogeneous
%           coordinates for points in 2D. The data may have NaN values.
%        
% Output:   norm_mat is a 3x3xC array. Stores the normalization matrices
%           for all cameras, i.e. norm_mat(:,:,c) is the normalization
%           matrix for camera c.

function norm_mat = compute_normalization_matrices( points2d )

[N M CAMERAS] = size(points2d);
pC = zeros(N,CAMERAS);
norm_mat = zeros(N,N,CAMERAS);
%Calculate pCentroid
for i = 1:CAMERAS
    sumP = zeros(3,1);
    nonNanCount = 0;
    for j = 1:M
        if ~isnan(points2d(1,j,i))
            sumP = sumP + points2d(:,j,i);
            nonNanCount = nonNanCount + 1;
        end
    end
    pC(:,i) = sumP/nonNanCount;
end

%calculate dC
dC = zeros(1,CAMERAS);
for i = 1:CAMERAS
    sumD = 0;
    nonNanCount = 0;
    for j = 1:M
         if ~isnan(points2d(1,j,i))
            sumD = sumD + norm(points2d(:,j,i) - pC(:,i));
            nonNanCount = nonNanCount + 1;
         end
    end
    dC(i) = sumD/nonNanCount;
    norm_mat(:,:,i) = (sqrt(2)/dC(i))*[1 0 -pC(1,i); 0 1 -pC(2,i); 0 0 dC(i)/sqrt(2)];
end

end

%-------------------------
% TODO: FILL IN THIS PART