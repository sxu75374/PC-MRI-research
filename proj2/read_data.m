function [data_complex, data_mag, data_p, info_complex, info_mag, info_p] = read_data(filelist)
%%
c1=0;
c2=0;
c3=0;
for i = 1:60:length(filelist)
    c1 = c1+1;
    for l = 1:20
        path_p = filelist{i+l-1,1};
        temp1 = dicominfo(path_p);
        info_p{c1,l} = temp1;
        temp2 = double(dicomread(path_p));
        data_p(:,:,c1,l) = temp2 * temp1.RescaleSlope + temp1.RescaleIntercept;
    end
end
for i2 = 21:60:length(filelist)
    c2 = c2+1;
    for k = 1:20
        path_mag = filelist{i2+k-1,1};
        info_mag{c2,k} = dicominfo(path_mag);
        data_mag(:,:,c2,k) = double(dicomread(path_mag));
    end
end
for i3 = 41:60:length(filelist)
    c3 = c3+1;
        for j = 1:20
        path_complex = filelist{i3+j-1,1};
        info_complex{c3,j} = dicominfo(path_complex);
        data_complex(:,:,c3,j) = double(dicomread(path_complex));
    end
end
end
