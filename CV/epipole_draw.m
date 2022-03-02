function [] = epipole_draw(I1, I2)

points1 = detectSURFFeatures(I1);
points2 = detectSURFFeatures(I2);

[features1, valid_points1] = extractFeatures(I1, points1);
[features2, valid_points2] = extractFeatures(I2, points2);

%Use the sum of absolute differences (SAD) metric to determine indices of matching features.
indexPairs = matchFeatures(features1, features2);

%Retrieve locations of matched points for each image
matched_points1 = valid_points1(indexPairs(:, 1), :);
matched_points2 = valid_points2(indexPairs(:, 2), :);
matched_points1L = matched_points1.Location;
matched_points2L = matched_points2.Location;

[fLMedS, inliers] = estimateFundamentalMatrix(matched_points1L, matched_points2L, 'NumTrials', 4000);

% Plot
figure; 
subplot(121);
imshow(I1); 
% title('Inliers and Epipolar Lines in First Image'); hold on;
plot(matched_points1L(inliers,1),matched_points1L(inliers,2),'go')
epiLines = epipolarLine(fLMedS',matched_points2L(inliers,:));
points = lineToBorderPoints(epiLines,size(I1));
line(points(:,[1,3])',points(:,[2,4])');


subplot(122); 
imshow(I2);
% title('Inliers and Epipolar Lines in Second Image'); hold on;
plot(matched_points2L(inliers,1),matched_points2L(inliers,2),'go')
epiLines = epipolarLine(fLMedS,matched_points1L(inliers,:));
points = lineToBorderPoints(epiLines,size(I2));
line(points(:,[1,3])',points(:,[2,4])');

end

