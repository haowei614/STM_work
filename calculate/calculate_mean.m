load work_files\stm_genuineFeatureCell.mat
load work_files\stm_spoofFeatureCell.mat
STM_feature_true = stm_genuineFeatureCell;
STM_feature_fake = stm_spoofFeatureCell;

%% calculate mean of real speech

%Cam * Num Of Signal
mean_Array_cam_real = [];
for i = 1:size(STM_feature_true,1)
    data = STM_feature_true{i};
    data = data';
    mean_true = mean(data);
    mean_Array_cam_real = [mean_Array_cam_real; mean_true];
end
%save('mean_array_cam_real','mean_Array_cam_real')

%freq * Num Of Signal
mean_Array_freq_real = [];
for i = 1:size(STM_feature_true,1)
    data = STM_feature_true{i};
    mean_true = mean(data',2);
    mean_Array_freq_real = [mean_Array_freq_real; mean_true'];
end
    
len_100Hz = fix(f/fs*size(mean_Array_freq_real,2))+1;
mean_array_freq_real = zeros(1000,len_100Hz);

for i = 1:size(mean_Array_freq_real,1)
    mean_array_freq_real(i,:) = mean_Array_freq_real(i,1:len_100Hz);
end
%save('mean_array_freq_real','mean_array_freq_real')


%% calculate mean of fake speech
%Cam * Num Of Signal
mean_Array_cam_fake = [];
for i = 1:size(STM_feature_fake,1)
    data = STM_feature_fake{i};
    data = data';
    mean_fake = mean(data);
    mean_Array_cam_fake = [mean_Array_cam_fake; mean_fake];
end
%save('mean_array_cam_fake','mean_Array_cam_fake')

%freq * Num Of Signal
mean_Array_freq_fake = [];
for i = 1:size(STM_feature_fake,1)
    data = STM_feature_fake{i};
    mean_fake = mean(data',2);
    mean_Array_freq_fake = [mean_Array_freq_fake; mean_fake'];
end
    
len_100Hz = fix(f/fs*size(mean_Array_freq_fake,2))+1;
mean_array_freq_fake = zeros(1000,len_100Hz);

for i = 1:size(mean_Array_freq_fake,1)
    mean_array_freq_fake(i,:) = mean_Array_freq_fake(i,1:len_100Hz);
end
%save('mean_array_freq_fake','mean_array_freq_fake')
