%% Manual keypoint correspondences
I1 = imread('');
I2 = imread('');
[mp, fp] = cpselect(I1, I2, 'Wait', true);
t = fitgeotrans(mp, fp, 'Iwm', 6);
figure()
ax = axes;
showMatchedFeatures(I1, I2, mp, fp, 'montage', 'Parent', ax);
title(ax, 'Candidate point matches')