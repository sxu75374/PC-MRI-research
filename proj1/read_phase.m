function [image_data, info] = read_phase(DICOM_path)
%%
DICOM_names = dir(fullfile(DICOM_path,'*.IMA'));
for idx = 1:24
    filepath = fullfile(DICOM_path, DICOM_names(idx).name);
%     info{idx,:} = dicominfo(filepath);
%     image_data(:,:,idx) = double(dicomread(filepath));
    temp1 = dicominfo(filepath);
    info{idx,:} = temp1;
    temp2 = double(dicomread(filepath));
    image_data(:,:,idx) = temp2 * temp1.RescaleSlope + temp1.RescaleIntercept;
end
end
