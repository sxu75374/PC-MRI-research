function [Q, nzero] = getQ_separate(data_complex, data_phase, xmin, ymin, width, height)

selected_ROI = data_complex(ymin:ymin+height-1,xmin:xmin+width-1);
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
ROI_mask = zeros(length(data_complex(:,1)),length(data_complex(1,:)));
ROI_mask(ymin:ymin+height-1,xmin:xmin+width-1) = temp;
% figure
% imagesc(ROI_mask)

%% filter the phase image by the mask
ROI_phase = data_phase.*ROI_mask;

%% convert each phase value into radian and compute the velocity 
venc = 100;
ROI_velocity = zeros(size(ROI_mask));
nzero = 0;
for i = 1:length(ROI_mask(:,1))
    for j = 1:length(ROI_mask(1,:))
        if ROI_mask(i,j) ~= 0
            nzero = nzero + 1;
            ROI_velocity(i,j) = ROI_phase(i,j)/40.96;
            
        end
    end
end

%% compute Q
area = 0.05208*0.05208*nzero;
ROI_velocity_avg = sum(ROI_velocity(:))/nzero;
Q = ROI_velocity_avg*area;
end
