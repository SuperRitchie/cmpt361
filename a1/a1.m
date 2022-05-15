% 1
lowfreq = imresize(im2double(rgb2gray(imread('grizzly_bear.jpg'))), [500 500]);
imwrite(lowfreq,'LP.png')

highfreq = imresize(im2double(rgb2gray(imread('brick_wall.jpg'))), [500 500]);
imwrite(highfreq,'HP.png')

% 2
low_fou = fftshift(abs(fft2(lowfreq))/50);
imwrite(low_fou, 'LP-freq.png')

high_fou = fftshift(abs(fft2(highfreq))/50);
imwrite(high_fou, 'HP-freq.png')

% 3
gausskern = fspecial('gaussian', 50, 2.5);
surf(gausskern);
saveas(gcf, 'gaus-surf.png')

sob = [-1 0 1; -2 0 2; -1 0 1]; % x-direction sobel kernel
surf(conv2(gausskern, sob));
gaussdog = conv2(gausskern, sob);
saveas(gcf, 'dog-surf.png')

gausslow = imfilter(lowfreq, gausskern);
imwrite(gausslow,'LP-filt.png')
gausslow_fou = fftshift(abs(fft2(gausslow))/2);
imwrite(gausslow_fou, 'LP-filt-freq.png')

gausshigh = imfilter(highfreq, gausskern);
imwrite(gausshigh,'HP-filt.png')
gausshigh_fou = fftshift(abs(fft2(gausshigh))/2);
imwrite(gausshigh_fou, 'HP-filt-freq.png')

gaussdoglow = imfilter(lowfreq, gaussdog);
imwrite(gaussdoglow,'LP-dogfilt.png')
gaussdoglow_fou = fftshift(abs(fft2(gaussdoglow))/5);
imwrite(gaussdoglow_fou, 'LP-dogfilt-freq.png')

gaussdoghigh = imfilter(highfreq, gaussdog);
imwrite(gaussdoghigh,'HP-dogfilt.png')
gaussdoghigh_fou = fftshift(abs(fft2(gaussdoghigh))/5);
imwrite(gaussdoghigh_fou, 'HP-dogfilt-freq.png')

% 4
half_lowfreq = lowfreq(1:2:end, 1:2:end);
imwrite(half_lowfreq,'LP-sub2.png')
half_low_fou = fftshift(abs(fft2(half_lowfreq))/50);
imwrite(half_low_fou, 'LP-sub2-freq.png')

half_highfreq = highfreq(1:2:end, 1:2:end);
imwrite(half_highfreq,'HP-sub2.png')
half_high_fou = fftshift(abs(fft2(half_highfreq))/50);
imwrite(half_high_fou, 'HP-sub2-freq.png')

quarter_lowfreq = lowfreq(1:4:end, 1:4:end);
imwrite(quarter_lowfreq,'LP-sub4.png')
quarter_low_fou = fftshift(abs(fft2(quarter_lowfreq))/50);
imwrite(quarter_low_fou, 'LP-sub4-freq.png')

quarter_highfreq = highfreq(1:4:end, 1:4:end);
imwrite(quarter_highfreq,'HP-sub4.png')
quarter_high_fou = fftshift(abs(fft2(quarter_highfreq))/50);
imwrite(quarter_high_fou, 'HP-sub4-freq.png')

highfreq_aa2 = imgaussfilt(highfreq, 2.5, "FilterSize", 21);
highfreqsamp_aa2 = highfreq_aa2(1:2:end, 1:2:end);
imwrite(highfreqsamp_aa2,'HP-sub2-aa.png')
half_high_fou2 = abs(fftshift(fft2(highfreqsamp_aa2)/5));
imwrite(half_high_fou2, 'HP-sub2-aa-freq.png')

highfreq_aa4 = imgaussfilt(highfreq, 3, "FilterSize", 31);
highfreqsamp_aa4 = highfreq_aa4(1:4:end, 1:4:end);
imwrite(highfreqsamp_aa4,'HP-sub4-aa.png')
half_high_fou4 = abs(fftshift(fft2(highfreqsamp_aa4)/5));
imwrite(half_high_fou4, 'HP-sub4-aa-freq.png')

% 5
optimalLow = edge(lowfreq, 'canny');
lowlowLow = edge(lowfreq, 'canny', [0.2 0.3]);
highlowLow = edge(lowfreq, 'canny', [0.199 0.2]);
lowhighLow = edge(lowfreq, 'canny', [0.1 0.5]);
highhighLow = edge(lowfreq, 'canny', [0.35 0.6]);
imwrite(optimalLow, 'LP-canny-optimal.png')
imwrite(lowlowLow, 'LP-canny-lowlow.png')
imwrite(highlowLow, 'LP-canny-highlow.png')
imwrite(lowhighLow, 'LP-canny-lowhigh.png')
imwrite(highhighLow, 'LP-canny-highhigh.png')

optimalHigh = edge(highfreq, 'canny');
lowlowHigh = edge(highfreq, 'canny', [0.2 0.3]);
highlowHigh = edge(highfreq, 'canny', [0.199 0.2]);
lowhighHigh = edge(highfreq, 'canny', [0.1 0.5]);
highhighHigh = edge(highfreq, 'canny', [0.35 0.6]);
imwrite(optimalHigh, 'HP-canny-optimal.png')
imwrite(lowlowHigh, 'HP-canny-lowlow.png')
imwrite(highlowHigh, 'HP-canny-highlow.png')
imwrite(lowhighHigh, 'HP-canny-lowhigh.png')
imwrite(highhighHigh, 'HP-canny-highhigh.png')