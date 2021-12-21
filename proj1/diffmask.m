%% Same selected ROI area with same threshold, different mask based on each complex image
close
clear
clc
%% load data(double)
dcm_path_phase = '/Users/xs/Documents/MATLAB/DR2021fall/proj1/FLOW_PC3D_TRA_VENC100_P_0008';
[data_phase, info_phase] = read_phase(dcm_path_phase);

dcm_path_mag = '/Users/xs/Documents/MATLAB/DR2021fall/proj1/FLOW_PC3D_TRA_VENC100_MAG_0007';
[data_mag, info_mag] = read_data(dcm_path_mag);

dcm_path_complex = '/Users/xs/Documents/MATLAB/DR2021fall/proj1/FLOW_PC3D_TRA_VENC100_0006';
[data_complex, info_complex] = read_data(dcm_path_complex);

%% display the complex map
figure
imagesc(data_complex(:,:,10),[0 300])
colorbar, title('original image')
colormap gray;

%% select the ROI
rect = getrect;

%% get the location information and create a ICA mask
xmin = round(rect(1));
ymin = round(rect(2));
width =round(rect(3));
height = round(rect(4));

%% compute Q
Q = zeros(1,24);
nzero_idx = zeros(1,24);
for n = 1:24
    temp1 = 0;
    temp2 = 0;
    [temp1, temp2] = getQ_separate(data_complex(:,:,n), data_phase(:,:,n), xmin, ymin, width, height);
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
Qmin = min(Q(1:19));
Qmax = max(Q(1:19));
Qmean = sum(Q(1:19))/length(Q(1:19));
PI = (Qmax-Qmin)/Qmean;
RI = (Qmax-Qmin)/Qmax;
