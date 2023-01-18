load work_files\stm_genuineFeatureCell.mat
load work_files\stm_spoofFeatureCell.mat
STM_feature_true = stm_genuineFeatureCell;
STM_feature_fake = stm_spoofFeatureCell;

%% calculate variance of real speech
%Cam * Num Of Signal
variance_Array_cam_real = [];
for i = 1:size(STM_feature_true,1)
    data = STM_feature_true{i};
    data = data';
    variance_true = var(data);
    variance_Array_cam_real = [variance_Array_cam_real; variance_true];
end
%save('variance_Array_cam_real','variance_Array_cam_real')

%freq * Num Of Signal
variance_Array_freq_real = [];
for i = 1:size(STM_feature_true,1)
    data = STM_feature_true{i};
    variance_true = var(data',0,2);
    variance_Array_freq_real = [variance_Array_freq_real; variance_true'];
end
    
len_100Hz = fix(f/fs*size(variance_Array_freq_real,2))+1;
variance_array_freq_real = zeros(1000,len_100Hz);

for i = 1:size(variance_Array_freq_real,1)
    variance_array_freq_real(i,:) = variance_Array_freq_real(i,1:len_100Hz);
end
%save('variance_array_freq_real','variance_array_freq_real')


%% calculate variance of fake speech
%Cam * Num Of Signal
variance_Array_cam_fake = [];
parfor i = 1:size(STM_feature_fake,1)
    data = STM_feature_fake{i};
    data = data';
    variance_fake = var(data);
    variance_Array_cam_fake = [variance_Array_cam_fake; variance_fake];
end
%save('variance_array_freq_fake','variance_Array_cam_fake')

%freq * Num Of Signal 
variance_Array_freq_fake = [];
for i = 1:size(STM_feature_fake,1)
    data = STM_feature_fake{i};
    variance_fake = var(data',[],2);
    variance_Array_freq_fake = [variance_Array_freq_fake; variance_fake'];
end
    
len_100Hz = fix(f/fs*size(variance_Array_freq_fake,2))+1;
variance_array_freq_fake = zeros(1000,len_100Hz);

for i = 1:size(variance_Array_freq_fake,1)
    variance_array_freq_fake(i,:) = variance_Array_freq_fake(i,1:len_100Hz);
end

%save('variance_array_freq_fake','variance_array_freq_fake')