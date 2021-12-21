% close
% clear
% clc
%% load data
% path = '/Users/xs/Documents/MATLAB/DR2021fall/proj2/DVR';
% fulllist = getAllFiles(path);
% [data_complex, data_mag, data_p, info_complex, info_mag, info_p] = read_data(fulllist);

set=12;
%% display the complex map for each of the dataset(12)
figure
imagesc(data_complex(:,:,set,1),[0 300])
colormap gray;

%% select the ROI
rect = getrect;

%% get the location information and create a ICA mask
xmin = round(rect(1));
ymin = round(rect(2));
width =round(rect(3));
height = round(rect(4));

%% compute Q
len = length(info_complex(1,:));
Q = zeros(1,len);
nzero_idx = zeros(1,len);
for n = 1:len
    temp1 = 0;
    temp2 = 0;
    [temp1, temp2] = getQ_separate(data_complex(:,:,set,n), data_p(:,:,set,n), xmin, ymin, width, height);
    Q(1,n) = temp1;
    nzero_idx(1,n) = temp2;
end
figure
plot(Q)
title('Q vs index(Same selected ROI area with same threshold, different mask based on each complex image)')
xlabel('index of the data')
ylabel('Q')
figure
plot(nzero_idx)
title('mask size(Same selected ROI area with same threshold, different mask based on each complex image)')
xlabel('index of the data')
ylabel('mask size')

%% compute PI RI
Qmin = min(Q(1:35));
Qmax = max(Q(1:35));
Qmean = sum(Q(1:35))/length(Q(1:35));
PI = (Qmax-Qmin)/Qmean;
RI = (Qmax-Qmin)/Qmax;


