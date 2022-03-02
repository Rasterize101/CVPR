clc, clear, close all

for i = 1:5
  imageFileName = sprintf('DSC_06%d.png', i+35);
  imageFileNames{i} = fullfile('calibration',imageFileName);
end

[imagePoints,boardSize,imagesUsed] = detectCheckerboardPoints(imageFileNames, 'PartialDetections', false);

imageFileNames = imageFileNames(imagesUsed);
for i = 1:numel(imageFileNames)
  I = imread(imageFileNames{i});
  subplot(2, 3, i);
  imshow(I);
  hold on;
  plot(imagePoints(:,1,i),imagePoints(:,2,i),'ro');
end

squareSizeInMM = 30;
worldPoints = generateCheckerboardPoints(boardSize,squareSizeInMM);

params = estimateCameraParameters(imagePoints, worldPoints);

figure()
showReprojectionErrors(params);
