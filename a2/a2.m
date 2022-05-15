% 1
S1_im1 = imresize(im2double(imread('S1-im1.png')), [750 750]);
S1_im2 = imresize(im2double(imread('S1-im2.png')), [750 750]);

S2_im1 = imresize(im2double(imread('S2-im1.png')), [750 750]);
S2_im2 = imresize(im2double(imread('S2-im2.png')), [750 750]);

S3_im1 = imresize(im2double(imread('S3-im1.png')), [750 750]);
S3_im2 = imresize(im2double(imread('S3-im2.png')), [750 750]);

S4_im1 = imresize(im2double(imread('S4-im1.png')), [750 750]);
S4_im2 = imresize(im2double(imread('S4-im2.png')), [750 750]);



S1fast_im1 = imresize(im2double(rgb2gray(imread('S1-im1.png'))), [750 750]);
S1fast_im1points = my_fast_detector(S1fast_im1, 12, -0.05);

S2fast_im1 = imresize(im2double(rgb2gray(imread('S2-im1.png'))), [750 750]);
S2fast_im1points = my_fast_detector(S2fast_im1, 12, -0.05);

S1fastR_im1 = imresize(im2double(rgb2gray(imread('S1-im1.png'))), [750 750]);
S1fastR_im1points = my_fast_detector(S1fastR_im1, 5, 1);

S2fastR_im1 = imresize(im2double(rgb2gray(imread('S2-im1.png'))), [750 750]);
S2fastR_im1points = my_fast_detector(S2fastR_im1, 5, 1);

%%%
figure(1)
S1cornerFast = detectHarrisFeatures(imresize(im2double(rgb2gray(imread('S1-im1.png'))), [750 750]), "MinQuality", 0.2);
plot(S1cornerFast.selectStrongest(50));
hold on
saveas(gcf, 'S1-fastR.png')


figure(2)
S1cornerFastR = detectHarrisFeatures(imresize(im2double(rgb2gray(imread('S2-im1.png'))), [750 750]), "MinQuality", 0.2);
plot(S1cornerFastR.selectStrongest(50));
saveas(gcf, 'S2-fastR.png')

%%%

figure(3)
I1 = imresize(im2double(rgb2gray(imread('S1-im1.png'))), [750 750]);
I2 = imresize(im2double(rgb2gray(imread('S1-im2.png'))), [750 750]);
points1 = detectORBFeatures(imresize(im2double(rgb2gray(imread('S1-im1.png'))), [750 750]));
points2 = detectORBFeatures(imresize(im2double(rgb2gray(imread('S1-im2.png'))), [750 750]));
[f1,vpts1] = extractFeatures(I1,points1);
[f2,vpts2] = extractFeatures(I2,points2);
indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);
legend('matched points 1','matched points 2');
saveas(gcf, 'S1-fastMatch.png')

figure(4)
I1 = imresize(im2double(rgb2gray(imread('S1-im1.png'))), [750 750]);
I2 = imresize(im2double(rgb2gray(imread('S1-im2.png'))), [750 750]);
points1 = detectSURFFeatures(imresize(im2double(rgb2gray(imread('S1-im1.png'))), [750 750]));
points2 = detectSURFFeatures(imresize(im2double(rgb2gray(imread('S1-im2.png'))), [750 750]));
[f1,vpts1] = extractFeatures(I1,points1);
[f2,vpts2] = extractFeatures(I2,points2);
indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);
legend('matched points 1','matched points 2');
saveas(gcf, 'S1-fastRMatch.png')

figure(5)
I1 = imresize(im2double(rgb2gray(imread('S2-im1.png'))), [750 750]);
I2 = imresize(im2double(rgb2gray(imread('S2-im2.png'))), [750 750]);
points1 = detectORBFeatures(imresize(im2double(rgb2gray(imread('S2-im1.png'))), [750 750]));
points2 = detectORBFeatures(imresize(im2double(rgb2gray(imread('S2-im2.png'))), [750 750]));
[f1,vpts1] = extractFeatures(I1,points1);
[f2,vpts2] = extractFeatures(I2,points2);
indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);
legend('matched points 1','matched points 2');
saveas(gcf, 'S2-fastMatch.png')

figure(6)
I1 = imresize(im2double(rgb2gray(imread('S2-im1.png'))), [750 750]);
I2 = imresize(im2double(rgb2gray(imread('S2-im2.png'))), [750 750]);
points1 = detectSURFFeatures(imresize(im2double(rgb2gray(imread('S2-im1.png'))), [750 750]));
points2 = detectSURFFeatures(imresize(im2double(rgb2gray(imread('S2-im2.png'))), [750 750]));
[f1,vpts1] = extractFeatures(I1,points1);
[f2,vpts2] = extractFeatures(I2,points2);
indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);
legend('matched points 1','matched points 2');
saveas(gcf, 'S2-fastRMatch.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I = S1_im1;
grayImage = im2gray(I);
points = detectSURFFeatures(grayImage);
[features, points] = extractFeatures(grayImage,points);


numImages = 2;
tforms(numImages) = projective2d(eye(3));

imageSize = zeros(numImages,2);


    pointsPrevious = points;
    featuresPrevious = features;
        
    I = S1_im2;
    
    grayImage = im2gray(I);    
    
    imageSize(2,:) = size(grayImage);
    
    points = detectSURFFeatures(grayImage);    
    [features, points] = extractFeatures(grayImage, points);
  
    indexPairs = matchFeatures(features, featuresPrevious, 'Unique', true);
       
    matchedPoints = points(indexPairs(:,1), :);
    matchedPointsPrev = pointsPrevious(indexPairs(:,2), :);        
    
    tforms(2) = estimateGeometricTransform2D(matchedPoints, matchedPointsPrev,...
        'projective', 'Confidence', 99.9, 'MaxNumTrials', 10000);
    
    tforms(2).T = tforms(2).T * tforms(2-1).T; 

for i = 1:2           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);    
end

avgXLim = mean(xlim, 2);
[~,idx] = sort(avgXLim);
centerIdx = floor((numel(tforms)+1)/2);
centerImageIdx = idx(centerIdx);

Tinv = invert(tforms(centerImageIdx));
for i = 1:2    
    tforms(i).T = tforms(i).T * Tinv.T;
end


for i = 1:2           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);
end
maxImageSize = max(imageSize);
xMin = min([1; xlim(:)]);
xMax = max([maxImageSize(2); xlim(:)]);
yMin = min([1; ylim(:)]);
yMax = max([maxImageSize(1); ylim(:)]);
width  = round(xMax - xMin);
height = round(yMax - yMin);

panorama = zeros([height width 3], 'like', I);
blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');  

xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width], xLimits, yLimits);
for i = 1:numImages
    if i == 1
        I = S1_im1;
   
    warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView);
                  
    mask = imwarp(true(size(I,1),size(I,2)), tforms(i), 'OutputView', panoramaView);
    
    panorama = step(blender, panorama, warpedImage, mask);
    end
    if i == 2
        I = S1_im2;
    warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView); 
    mask = imwarp(true(size(I,1),size(I,2)), tforms(i), 'OutputView', panoramaView);
    panorama = step(blender, panorama, warpedImage, mask);
    end
end

figure(7)
imwrite(panorama, 'S1-panorama.png')
imshow(panorama)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I = S2_im1;
grayImage = im2gray(I);
points = detectSURFFeatures(grayImage);
[features, points] = extractFeatures(grayImage,points);


numImages = 2;
tforms(numImages) = projective2d(eye(3));

imageSize = zeros(numImages,2);


    pointsPrevious = points;
    featuresPrevious = features;
        
    I = S2_im2;
    
    grayImage = im2gray(I);    
    
    imageSize(2,:) = size(grayImage);
    
    points = detectSURFFeatures(grayImage);    
    [features, points] = extractFeatures(grayImage, points);
  
    indexPairs = matchFeatures(features, featuresPrevious, 'Unique', true);
       
    matchedPoints = points(indexPairs(:,1), :);
    matchedPointsPrev = pointsPrevious(indexPairs(:,2), :);        
    
    tforms(2) = estimateGeometricTransform2D(matchedPoints, matchedPointsPrev,...
        'projective', 'Confidence', 99.9, 'MaxNumTrials', 10000);
    
    tforms(2).T = tforms(2).T * tforms(2-1).T; 

for i = 1:2           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);    
end

avgXLim = mean(xlim, 2);
[~,idx] = sort(avgXLim);
centerIdx = floor((numel(tforms)+1)/2);
centerImageIdx = idx(centerIdx);

Tinv = invert(tforms(centerImageIdx));
for i = 1:2    
    tforms(i).T = tforms(i).T * Tinv.T;
end


for i = 1:2           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);
end
maxImageSize = max(imageSize);
xMin = min([1; xlim(:)]);
xMax = max([maxImageSize(2); xlim(:)]);
yMin = min([1; ylim(:)]);
yMax = max([maxImageSize(1); ylim(:)]);
width  = round(xMax - xMin);
height = round(yMax - yMin);

panorama = zeros([height width 3], 'like', I);
blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');  

xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width], xLimits, yLimits);
for i = 1:numImages
    if i == 1
        I = S2_im1;
   
    warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView);
                  
    mask = imwarp(true(size(I,1),size(I,2)), tforms(i), 'OutputView', panoramaView);
    
    panorama = step(blender, panorama, warpedImage, mask);
    end
    if i == 2
        I = S2_im2;
    warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView); 
    mask = imwarp(true(size(I,1),size(I,2)), tforms(i), 'OutputView', panoramaView);
    panorama = step(blender, panorama, warpedImage, mask);
    end
end

figure(8)
imwrite(panorama, 'S2-panorama.png')
imshow(panorama)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I = S3_im1;
grayImage = im2gray(I);
points = detectSURFFeatures(grayImage);
[features, points] = extractFeatures(grayImage,points);


numImages = 2;
tforms(numImages) = projective2d(eye(3));

imageSize = zeros(numImages,2);


    pointsPrevious = points;
    featuresPrevious = features;
        
    I = S3_im2;
    
    grayImage = im2gray(I);    
    
    imageSize(2,:) = size(grayImage);
    
    points = detectSURFFeatures(grayImage);    
    [features, points] = extractFeatures(grayImage, points);
  
    indexPairs = matchFeatures(features, featuresPrevious, 'Unique', true);
       
    matchedPoints = points(indexPairs(:,1), :);
    matchedPointsPrev = pointsPrevious(indexPairs(:,2), :);        
    
    tforms(2) = estimateGeometricTransform2D(matchedPoints, matchedPointsPrev,...
        'projective', 'Confidence', 99.9, 'MaxNumTrials', 10000);
    
    tforms(2).T = tforms(2).T * tforms(2-1).T; 

for i = 1:2           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);    
end

avgXLim = mean(xlim, 2);
[~,idx] = sort(avgXLim);
centerIdx = floor((numel(tforms)+1)/2);
centerImageIdx = idx(centerIdx);

Tinv = invert(tforms(centerImageIdx));
for i = 1:2    
    tforms(i).T = tforms(i).T * Tinv.T;
end


for i = 1:2           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);
end
maxImageSize = max(imageSize);
xMin = min([1; xlim(:)]);
xMax = max([maxImageSize(2); xlim(:)]);
yMin = min([1; ylim(:)]);
yMax = max([maxImageSize(1); ylim(:)]);
width  = round(xMax - xMin);
height = round(yMax - yMin);

panorama = zeros([height width 3], 'like', I);
blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');  

xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width], xLimits, yLimits);
for i = 1:numImages
    if i == 1
        I = S3_im1;
   
    warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView);
                  
    mask = imwarp(true(size(I,1),size(I,2)), tforms(i), 'OutputView', panoramaView);
    
    panorama = step(blender, panorama, warpedImage, mask);
    end
    if i == 2
        I = S3_im2;
    warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView); 
    mask = imwarp(true(size(I,1),size(I,2)), tforms(i), 'OutputView', panoramaView);
    panorama = step(blender, panorama, warpedImage, mask);
    end
end

figure(9)
imwrite(panorama, 'S3-panorama.png')
imshow(panorama)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I = S4_im1;
grayImage = im2gray(I);
points = detectSURFFeatures(grayImage);
[features, points] = extractFeatures(grayImage,points);


numImages = 2;
tforms(numImages) = projective2d(eye(3));

imageSize = zeros(numImages,2);


    pointsPrevious = points;
    featuresPrevious = features;
        
    I = S4_im2;
    
    grayImage = im2gray(I);    
    
    imageSize(2,:) = size(grayImage);
    
    points = detectSURFFeatures(grayImage);    
    [features, points] = extractFeatures(grayImage, points);
  
    indexPairs = matchFeatures(features, featuresPrevious, 'Unique', true);
       
    matchedPoints = points(indexPairs(:,1), :);
    matchedPointsPrev = pointsPrevious(indexPairs(:,2), :);        
    
    tforms(2) = estimateGeometricTransform2D(matchedPoints, matchedPointsPrev,...
        'projective', 'Confidence', 99.9, 'MaxNumTrials', 10000);
    
    tforms(2).T = tforms(2).T * tforms(2-1).T; 

for i = 1:2           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);    
end

avgXLim = mean(xlim, 2);
[~,idx] = sort(avgXLim);
centerIdx = floor((numel(tforms)+1)/2);
centerImageIdx = idx(centerIdx);

Tinv = invert(tforms(centerImageIdx));
for i = 1:2    
    tforms(i).T = tforms(i).T * Tinv.T;
end


for i = 1:2           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);
end
maxImageSize = max(imageSize);
xMin = min([1; xlim(:)]);
xMax = max([maxImageSize(2); xlim(:)]);
yMin = min([1; ylim(:)]);
yMax = max([maxImageSize(1); ylim(:)]);
width  = round(xMax - xMin);
height = round(yMax - yMin);

panorama = zeros([height width 3], 'like', I);
blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');  

xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width], xLimits, yLimits);
for i = 1:numImages
    if i == 1
        I = S4_im1;
   
    warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView);
                  
    mask = imwarp(true(size(I,1),size(I,2)), tforms(i), 'OutputView', panoramaView);
    
    panorama = step(blender, panorama, warpedImage, mask);
    end
    if i == 2
        I = S4_im2;
    warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView); 
    mask = imwarp(true(size(I,1),size(I,2)), tforms(i), 'OutputView', panoramaView);
    panorama = step(blender, panorama, warpedImage, mask);
    end
end

figure(10)
imwrite(panorama, 'S4-panorama.png')
imshow(panorama)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function corners = my_fast_detector(image, n, t)
    rows = size(image, 1);
    columns = size(image, 2);
    corners = false(rows, columns);

    for i = 1:rows
        count = 0;
        for j = 1:columns
            contingent  = false(rows, columns);
            I = image(rows, columns);
            for left = 1:7
                if(j - left >= 1)
                    if(image(i, j - left) > I + t)
                        contingent(i, j) = true;
                        count = count + 1;
 
                    end
                end 
            end
            for right = 1:7
                if(j + right <= columns)
                    if(image(i, j + right) > I + t)
                        contingent(i, j) = true;
                        count = count + 1;
                    end
                end 
            end
            for up = 1:7
                if(i - up >= 1)
                    if(image(i - up, j) > I + t)
                        contingent(i, j) = true;
                        count = count + 1;
                    end
                end 
            end

            for down = 1:7
                if(i + down <= rows)
                    if(image(i + down, j) > I + t)
                        contingent(i, j) = true;
                        count = count + 1;
                    end
                end 
            end
            if count >= 16 && count >= n
                corners(i, j) = true;
            end
        end
        
    end     
end