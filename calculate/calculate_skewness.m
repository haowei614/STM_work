load work_files\stm_genuineFeatureCell.mat
load work_files\stm_spoofFeatureCell.mat
STM_feature_true = stm_genuineFeatureCell;
STM_feature_fake = stm_spoofFeatureCell;

%% calculate skewness of real speech
%Cam * Num Of Signal
skewness_Array_cam_real = [];
for i = 1:size(STM_feature_true,1)
    data = STM_feature_true{i};
    data = data';
    skewness_true = skewness(data);
    skewness_Array_cam_real = [skewness_Array_cam_real; skewness_true];
end
%save('skewness_Array_cam_real','skewness_Array_cam_real')

%freq * Num Of Signal
skewness_Array_freq_real = [];
for i = 1:size(STM_feature_true,1)
    data = STM_feature_true{i};
    skewness_true = skewness(data',[],2);
    skewness_Array_freq_real = [skewness_Array_freq_real; skewness_true'];
end
    
len_100Hz = fix(f/fs*size(skewness_Array_freq_real,2))+1;
skewness_array_freq_real = zeros(1000,len_100Hz);

for i = 1:size(skewness_Array_freq_real,1)
    skewness_array_freq_real(i,:) = skewness_Array_freq_real(i,1:len_100Hz);
end
%save('skewness_array_freq_real','skewness_array_freq_real')


%% calculate skewness of fake speech
%Cam * Num Of Signal
skewness_Array_cam_fake = [];
parfor i = 1:size(STM_feature_fake,1)
    data = STM_feature_fake{i};
    data = data';
    skewness_fake = skewness(data);
    skewness_Array_cam_fake = [skewness_Array; skewness_fake];
end
%save('skewness_array_freq_fake','skewness_')

%freq * Num Of Signal 
skewness_Array_freq_fake = [];
for i = 1:size(STM_feature_fake,1)
    data = STM_feature_fake{i};
    skewness_fake = skewness(data',[],2);
    skewness_Array_freq_fake = [skewness_Array_freq_fake; skewness_fake'];
end
    
len_100Hz = fix(f/fs*size(skewness_Array_freq_fake,2))+1;
skewness_array_freq_fake = zeros(1000,len_100Hz);

for i = 1:size(skewness_Array_freq_fake,1)
    skewness_array_freq_fake(i,:) = skewness_Array_freq_fake(i,1:len_100Hz);
end

%save('skewness_array_freq_fake','skewness_array_freq_fake')






