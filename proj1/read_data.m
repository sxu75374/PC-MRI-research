function [image_data, info] = read_data(DICOM_path)
%%
DICOM_names = dir(fullfile(DICOM_path,'*.IMA'));
for idx = 1:24
    filepath = fullfile(DICOM_path, DICOM_names(idx).name);
    info{idx,:} = dicominfo(filepath);
    image_data(:,:,idx) = double(dicomread(filepath));
end
end
