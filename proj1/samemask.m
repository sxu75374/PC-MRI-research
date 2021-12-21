%% same mask based on the 1st complex image
close
clear
clc
%% load data(double)
dcm_path_phase = '/Users/xs/Documents/MATLAB/DR2021fall/proj1/FLOW_PC3D_TRA_VENC100_P_0008';
[data_phase, info_phase] = read_phase(dcm_path_phase);
% data = data_phase * info_phase.RescaleSlope + info_phase.RescaleIntercept;
dcm_path_mag = '/Users/xs/Documents/MATLAB/DR2021fall/proj1/FLOW_PC3D_TRA_VENC100_MAG_0007';
[data_mag, info_mag] = read_data(dcm_path_mag);

dcm_path_complex = '/Users/xs/Documents/MATLAB/DR2021fall/proj1/FLOW_PC3D_TRA_VENC100_0006';
[data_complex, info_complex] = read_data(dcm_path_complex);

%% display the complex map
figure
complex1 = data_complex(:,:,1);
phase1 = data_phase(:,:,1);
imagesc(data_complex(:,:,1),[0 300])
colorbar, title('original image')
colormap gray;

%% select the ROI
rect = getrect;

%% get the location information and create a ICA mask
xmin = round(rect(1));
ymin = round(rect(2));
width =round(rect(3));
height = round(rect(4));
selected_ROI = complex1(ymin:ymin+height-1,xmin:xmin+width-1);
min_ROI = min(selected_ROI(:));
max_ROI = max(selected_ROI(:));
ROI_normalized = selected_ROI/max_ROI;

temp = zeros(height,width);
thre = 0.55;
for i=1:height
    for j=1:width
        if ROI_normalized(i,j)<thre
            temp(i,j)=0;
        else
            temp(i,j)=1;
        end
    end
end
ROI_mask = zeros(length(complex1(:,1)),length(complex1(1,:)));
ROI_mask(ymin:ymin+height-1,xmin:xmin+width-1) = temp;
figure
imagesc(ROI_mask)
colorbar, title('ICA mask')
colormap gray;

%% compute Q
Q = zeros(1,24);
nzero_idx = zeros(1,24);
for n = 1:24
    temp1 = 0;
    temp2 = 0;
    [temp1, temp2] = getQ(data_phase(:,:,n), ROI_mask);
    Q(1,n) = temp1;
    nzero_idx(1,n) = temp2;
end
figure
plot(Q)
title('Q vs index(same mask based on the 1st complex image)')
xlabel('index of the data')
ylabel('Q')
figure
plot(nzero_idx)
title('mask size(same mask based on the 1st complex image)')
xlabel('index of the data')
ylabel('mask size')

%% compute PI RI
Qmin = min(Q(1:19));
Qmax = max(Q(1:19));
Qmean = sum(Q(1:19))/length(Q(1:19));
PI = (Qmax-Qmin)/Qmean;
RI = (Qmax-Qmin)/Qmax;

% Q2 = getQ(data_phase(:,:,2), info_phase{2,1}, ROI_mask);