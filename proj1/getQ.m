function [Q,nzero] = getQ(data_phase, ROI_mask)

%% filter the phase image by the mask
p = data_phase;
ROI_phase = p.*ROI_mask;
% figure
% imagesc(ROI_phase)
% colorbar, title('filtered phase image by the ICA mask')
% colormap gray;

%% convert each phase value into radian and compute the velocity 
venc = 100;
ROI_velocity = zeros(size(ROI_mask));
nzero = 0;
for i = 1:length(ROI_mask(:,1))
    for j = 1:length(ROI_mask(1,:))
        if ROI_mask(i,j) ~= 0
            nzero = nzero + 1;
%             ROI_phase_rad(i,j) = ((ROI_phase(i,j)-b)/8191*360-180)/180*pi;
%             ROI_velocity(i,j) = (ROI_phase_rad(i,j)/pi)*venc;
            ROI_velocity(i,j) = ROI_phase(i,j)/40.96;
        end
    end
end
% figure()
% imagesc(ROI_phase_rad)
% colormap gray;
%% compute Q
area = 0.05208*0.05208*nzero; % use 0.5208mm
ROI_velocity_avg = sum(ROI_velocity(:))/nzero;
Q = ROI_velocity_avg*area;
end
