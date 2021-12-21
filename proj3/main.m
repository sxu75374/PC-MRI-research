clear;
clc;
% load data
path = '/Users/xs/Documents/MATLAB/DR2021fall/proj3/7T-LSA/BF_s005';
fulllist = getAllFiles(path);
[data_complex, data_mag, data_p, info_complex, info_mag, info_p] = read_data(fulllist);

set=1;

%% display the complex map for each of the dataset(12)
figure('Name', 'draw ROI')
imagesc(data_complex(:,:,set,1), [0 300])
colormap gray;
% colormap gray;
%% select the ROI
rect = drawfreehand;
xy = rect.Position;
xCoordinates = xy(:, 1);
yCoordinates = xy(:, 2);
hold on
plot(xCoordinates, yCoordinates, 'r.', 'LineWidth', 2, 'MarkerSize', 12);

%% create a mask
BW = poly2mask(xCoordinates,yCoordinates,980,992);
figure('Name','ROI')
imshow(BW)
temp = zeros(980,992);
temp2 = zeros(980,992);

%% get Background
for i = 1:20
    temp = data_p(:,:,set,i)/40.96;
    temp2 = temp2+temp;
end
mean_phaseimage = temp2/20;
background = medfilt2(mean_phaseimage,[21 21]);

%% remove Background
p_BGremoved = zeros(980,992,20);
temp2 = zeros(980,992);
for i = 1:20
    p_BGremoved(:,:,i) = data_p(:,:,set,i)/40.96-background;
end
% cyclemean_expand_51 = padding(cyclemean,51);
% background = median(cyclemean_expand_51,1,51);
hold on
plot(xCoordinates, yCoordinates, 'r.', 'LineWidth', 2, 'MarkerSize', 12);
figure('Name', 'Background')
imagesc(background)
colormap gray;
hold on
plot(xCoordinates, yCoordinates, 'r.', 'LineWidth', 2, 'MarkerSize', 12);

%% ROI region
figure('Name', 'draw ROI')
imagesc(data_complex(:,:,set,1), [0 300])
colormap gray;
hold on
plot(xCoordinates, yCoordinates, 'r.', 'LineWidth', 2, 'MarkerSize', 12);
figure('Name', 'velocity map')
imagesc(p_BGremoved(:,:,1))
colormap gray
new = p_BGremoved(:,:,1);
hold on
plot(xCoordinates, yCoordinates, 'r.', 'LineWidth', 2, 'MarkerSize', 12);


%% compute pixelwise SNR for image
Venc = 20;
% a = zeros(1,20);
% for i = 1:20
%     a(1,i) = std(data_complex(:,:,1,i));
% end

% signal = zeros(980,992);
% noise = zeros(980,992);
% SNR_ma = zeros(980,992);
% for i = 1:980
%     for j = 1:992
%         signal(i,j) = data_mag(i,j,set,1);
%         temp = zeros(1,20);
%         for k = 1:20
%             temp(1,k) = data_p(i,j,set,k);
%         end
%         noise(i,j) = std(temp);
%     end
% end

signal = zeros(980,992);
noise = zeros(980,992);
% data_p_filtered = zeros(980,992,20);
% for k =1:20
%     data_p_filtered(:,:,k) = medfilt2(data_p(:,:,set,k),[21 21]);
% end

for i = 1:980
    for j = 1:992
        temp1 = zeros(1,20);
        temp2 = zeros(1,20);
        for k = 1:20
            temp1(1,k) = data_mag(i,j,set,k);
            temp2(1,k) = data_p(i,j,set,k);
        end
        signal(i,j) = mean(temp1);
        noise(i,j) = std(temp2);
    end
end

SNR_mag = zeros(980,992);
SD_v = zeros(980,992);
noise_mfiltered = medfilt2(noise,[21 21]);
for i = 1:980
    for j = 1:992
        SNR_mag(i,j) = 10*log10(data_mag(i,j,set,1)/noise_mfiltered(i,j));
        SD_v(i,j) = Venc/(pi*SNR_mag(i,j));
    end
end


Vmean = mean(mean(p_BGremoved(:,:,1)));
T1 = Vmean-2*SD_v;
T2 = Vmean+2*SD_v;
newb = normalize(new, T1, T2).*BW;
% new_nlm = imnlmfilt(new, 'DegreeOfSmoothing',5,'SearchWindowSize',9,'ComparisonWindowSize',3);% 10 9 3
% figure('NumberTitle', 'off', 'Name', 'Denoising image by NLM');
% imagesc(new_nlm);
% colormap gray;

%%
figure('Name','ROI: velocity map after removed background')
imagesc(new)
colormap gray;
hold on
plot(xCoordinates, yCoordinates, 'r.', 'LineWidth', 2, 'MarkerSize', 12);

figure('Name','ROI: Binary velocity map after removed BG')
imagesc(newb)
colormap gray;
hold on
plot(xCoordinates, yCoordinates, 'r.', 'LineWidth', 2, 'MarkerSize', 12);

figure('Name','ROI: SNR mag')
imagesc(SNR_mag)
colormap gray;
hold on
plot(xCoordinates, yCoordinates, 'r.', 'LineWidth', 2, 'MarkerSize', 12);
%%
figure('Name','ROI: SD_v')
imagesc(SD_v, [-100 100])
colormap gray;
hold on
plot(xCoordinates, yCoordinates, 'r.', 'LineWidth', 2, 'MarkerSize', 12);

%%
figure('Name', 'ROI: velocity map')
imagesc(data_p(:,:,set,1)/40.96)
colormap gray
hold on
plot(xCoordinates, yCoordinates, 'r.', 'LineWidth', 2, 'MarkerSize', 12);
[Lbw, numbw] = bwlabel(newb);
s = regionprops(Lbw,'BoundingBox');
r=struct2cell(s);
hold on;
for i=1:length(r)
    rectangle('position',r{i},'edgecolor','r','LineWidth',1.5)
    hold on
end
cc=bwconncomp(newb,4);
cc.NumObjects
%%
figure('Name', 'ROI: velocity map')
imagesc(data_complex(:,:,set,1), [0,300])
colormap gray
hold on;
for i=1:length(r)
    rectangle('position',r{i},'edgecolor','r','LineWidth',1.5)
    hold on
end
hold on
plot(xCoordinates, yCoordinates, 'r.', 'LineWidth', 2, 'MarkerSize', 12);

% newb_m = median(newb,1);
% figure
% imagesc(newb_m)
% colormap gray;

% new1 = imadjust(new);
% imshow(new1)

% % % draw the original histogram
% % Toy = round(abs(new)*255/4095);
% % a = max(max(F_noisy));
% % b = min(min(F_noisy));
% % [ai, aj] = find(a==F_noisy);
% % [bi, bj] = find(b==F_noisy);
% % Toy_hist = zeros(1,256);
% % height_toy = 980;
% % width_toy = 992;
% % for i = 1:height_toy
% %     for j = 1:width_toy
% %         Toy_hist(1,1+Toy(i,j)) = Toy_hist(1,1+Toy(i,j))+1;%count the frequence
% %         if Toy(i,j) <= 128
% %             Toy(i,j) == 0;
% %         end
% %     end
% % end
% % figure('NumberTitle', 'off', 'Name', 'Histogram of Frequency of pixels');
% % bar(Toy_hist);%step 1: obtain histogram
% % title('Histogram of Frequency of pixels')
% % xlabel('Intensity Value');
% % ylabel('Number of Pixels');
% % figure('NumberTitle', 'off', 'Name', 'Normalized probability histogram');
% % bar(Toy_hist/(height_toy*width_toy));%step 2: caluculate the normailzed probability histogram 
% % title('Normalized probability histogram')
% % xlabel('Intensity Value');
% % n = imbinarize(Toy);
% % figure
% % imshow(n)
% % ylabel('Number of Pixels/Total Number of Pixels');