load work_files\stm_genuineFeatureCell.mat
load work_files\stm_spoofFeatureCell.mat
STM_feature_true = stm_genuineFeatureCell;
STM_feature_fake = stm_spoofFeatureCell;

%% calculate kurtosis of real speech

%Cam * Num Of Signal
kurtosis_Array_cam_real = [];
for i = 1:size(STM_feature_true,1)
    data = STM_feature_true{i};
    data = data';
    kurtosis_true = kurtosis(data);
    kurtosis_Array_cam_real = [kurtosis_Array_cam_real; kurtosis_true];
end
%save('kurtosis_array_cam_real','kurtosis_Array_cam_real')

%freq * Num Of Signal
kurtosis_Array_freq_real = [];
for i = 1:size(STM_feature_true,1)
    data = STM_feature_true{i};
    kurtosis_true = kurtosis(data',[],2);
    kurtosis_Array_freq_real = [kurtosis_Array_freq_real; kurtosis_true'];
end
    
len_100Hz = fix(f/fs*size(kurtosis_Array_freq_real,2))+1;
kurtosis_array_freq_real = zeros(1000,len_100Hz);

for i = 1:size(kurtosis_Array_freq_real,1)
    kurtosis_array_freq_real(i,:) = kurtosis_Array_freq_real(i,1:len_100Hz);
end
%save('kurtosis_array_freq_real','kurtosis_array_freq_real')


%% calculate skewness of fake speech
%Cam * Num Of Signal
kurtosis_Array_cam_fake = [];
parfor i = 1:size(STM_feature_fake,1)
    data = STM_feature_fake{i};
    data = data';
    kurtosis_fake = kurtosis(data);
    kurtosis_Array_cam_fake = [kurtosis_Array_cam_fake; kurtosis_fake];
end
%save('kurtosis_array_cam_fake','kurtosis_Array_cam_fake')

%freq * Num Of Signal 
kurtosis_Array_freq_fake = [];
for i = 1:size(STM_feature_fake,1)
    data = STM_feature_fake{i};
    kurtosis_fake = kurtosis(data',[],2);
    kurtosis_Array_freq_fake = [kurtosis_Array_freq_fake; kurtosis_fake'];
end
    
len_100Hz = fix(f/fs*size(kurtosis_Array_freq_fake,2))+1;
kurtosis_array_freq_fake = zeros(1000,len_100Hz);

for i = 1:size(kurtosis_Array_freq_fake,1)
    kurtosis_array_freq_fake(i,:) = kurtosis_Array_freq_fake(i,1:len_100Hz);
end

%save('kurtosis_array_freq_fake','kurtosis_array_freq_fake')


