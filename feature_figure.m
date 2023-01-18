
%% kurtosis 
load work_files\kurtosis_Array_cam_fake.mat
load work_files\kurtosis_Array_cam_real.mat
load work_files\kurtosis_array_freq_fake.mat
load work_files\kurtosis_array_freq_real.mat

%Cam-kurtosis
figure; 
subplot(2,1,1);
plot(Cam,kurtosis_Array_cam_real(1,:),'-b'); 
hold on; % plot kurtosis distribution
plot(Cam,kurtosis_Array_cam_fake(1,:),'--r');
ylabel('Kurtosis'); xlabel('Cam');
title('Distribution of Kurtosis');
legend('real','fake')

%frequence-kurtosis
fs = 16e3; f = 100;
len_100Hz = fix(f/fs*size(kurtosis_array_freq_real,2))+1;
[~,len_STM_freq_real] = size(kurtosis_array_freq_real);
freq_STM_real = (0:len_STM_freq_real-1)/len_STM_freq_real*f;
subplot(212)
plot(freq_STM_real,kurtosis_array_freq_real(1,:),'-b');

hold on;
[~,len_STM_freq_fake] = size(kurtosis_array_freq_fake);
freq_STM_fake = (0:len_STM_freq_fake-1)/len_STM_freq_fake*f;
plot(freq_STM_fake,kurtosis_array_freq_fake(1,:),'--r');
xlabel('ModulationFrequency'); ylabel('Kurtosis');
title('Distribution of kurtosis');
legend('real','fake')

%% skewness 
load work_files\skewness_Array_cam_fake.mat
load work_files\skewness_Array_cam_real.mat
load work_files\skewness_array_freq_fake.mat
load work_files\skewness_array_freq_real.mat
% Cam-skewness 
figure; 
subplot(2,1,1);
plot(Cam,skewness_Array_cam_real(1,:),'-b'); 
hold on;% plot kurtosis distribution
plot(Cam,skewness_Array_cam_fake(1,:),'--r');
ylabel('Skewness'); xlabel('Cam');
title('Distribution of Skewness');
legend('real','fake')

%frequence-skewness 
fs = 16e3; f = 100;
len_100Hz = fix(f/fs*size(skewness_array_freq_real,2))+1;
% skewness_array_freq_real = zeros(1000,len_100Hz);
% parfor i = 1:size(skewness_Array_freq_real,1)
%     skewness_array_freq_real(i,:) = skewness_Array_freq_real(i,1:len_100Hz);
% end

[~,len_STM_freq_real] = size(skewness_array_freq_real);
freq_STM_real = (0:len_STM_freq_real-1)/len_STM_freq_real*f;
subplot(212)
plot(freq_STM_real,skewness_array_freq_real(1,:),'-b');

hold on;
[~,len_STM_freq_fake] = size(skewness_array_freq_fake);
freq_STM_fake = (0:len_STM_freq_fake-1)/len_STM_freq_fake*f;
plot(freq_STM_fake,skewness_array_freq_fake(1,:),'--r');
xlabel('ModulationFrequency'); ylabel('Skewness');
title('Distribution of Skewness');
legend('real','fake')
%% mean 
load work_files\mean_Array_cam_fake.mat
load work_files\mean_Array_cam_real.mat
load work_files\mean_array_freq_fake.mat
load work_files\mean_array_freq_real.mat
% Cam-mean 
figure; 
subplot(2,1,1);
plot(Cam,mean_Array_cam_real(1,:),'-b'); 
hold on; % plot kurtosis distribution
plot(Cam,mean_Array_cam_fake(1,:),'--r'); 
ylabel('Mean'); xlabel('Cam');
title('Distribution of Mean');
legend('real','fake')

%frequence-mean
fs = 16e3; f = 100;
len_100Hz = fix(f/fs*size(mean_Array_freq_real,2))+1;

[~,len_STM_freq_real] = size(mean_array_freq_real);
freq_STM_real = (0:len_STM_freq_real-1)/len_STM_freq_real*f;
subplot(212)
plot(freq_STM_real,mean_array_freq_real(1,:),'-b');
hold on;
[~,len_STM_freq_fake] = size(mean_array_freq_fake);
freq_STM_fake = (0:len_STM_freq_fake-1)/len_STM_freq_fake*f;
plot(freq_STM_fake,mean_array_freq_fake(1,:),'--r');
xlabel('ModulationFrequency'); ylabel('mean');
title('Distribution of mean');
legend('real','fake')


%==============first version(outdate)==================
% mean_array_freq_real = zeros(1000,len_100Hz);

% parfor i = 1:size(mean_Array_freq_real,1)
%     mean_array_freq_real(i,:) = mean_Array_freq_real(i,1:len_100Hz);
% end
% 
% len_100Hz = fix(f/fs*size(mean_Array_freq_fake,2))+1;
% mean_array_freq_fake = zeros(1000,len_100Hz);
% 
% for i = 1:size(mean_Array_freq_fake,1)
%     mean_array_freq_fake(i,:) = mean_Array_freq_fake(i,1:len_100Hz);
% end



%% variance 
load work_files\variance_Array_cam_fake.mat
load work_files\variance_Array_cam_real.mat
load work_files\variance_Array_freq_fake.mat
load work_files\variance_Array_freq_real.mat
% Cam-variance 
figure; 
subplot(2,1,1);
plot(Cam,variance_Array_cam_real(1,:),'-b'); 
hold on; % plot kurtosis distribution
plot(Cam,variance_Array_cam_fake(1,:),'--r'); 
ylabel('Variance'); xlabel('Cam');
title('Distribution of Variance');
legend('real','fake')

%frequence-variance
fs = 16e3; f = 100;
len_100Hz = fix(f/fs*size(variance_Array_freq_real,2))+1;

[~,len_STM_freq_real] = size(variance_array_freq_real);
freq_STM_real = (0:len_STM_freq_real-1)/len_STM_freq_real*f;
subplot(212)
plot(freq_STM_real,variance_array_freq_real(1,:),'-b');
hold on;
[~,len_STM_freq_fake] = size(variance_array_freq_fake);
freq_STM_fake = (0:len_STM_freq_fake-1)/len_STM_freq_fake*f;
plot(freq_STM_fake,variance_array_freq_fake(1,:),'--r');
xlabel('ModulationFrequency'); ylabel('variance');
title('Distribution of variance');
legend('real','fake')


%==============first version(outdate)==================
% mean_array_freq_real = zeros(1000,len_100Hz);
% parfor i = 1:size(mean_Array_freq_real,1)
%     variance_array_freq_real(i,:) = variance_Array_freq_real(i,1:len_100Hz);
% end
% 
% len_100Hz = fix(f/fs*size(variance_Array_freq_fake,2))+1;
% variance_array_freq_fake = zeros(1000,len_100Hz);
% 
% for i = 1:size(variance_Array_freq_fake,1)
%     variance_array_freq_fake(i,:) = variance_Array_freq_fake(i,1:len_100Hz);
% end






%% cepstrum  (test) 
% fs = 16000;
% T = length(stm_genuineFeatureCell{1})/fs;
% fig1 = figure(1);
% fm = -200:1/T:200;
% cyc_ERB = -186:185;
% imagesc(fm,cyc_ERB,10*log10(stm_genuineFeatureCell{1})-max(max(10*log10(stm_genuineFeatureCell{1}))))
% lim = caxis;
% caxis([-30 0])
% ylim([0 cyc_ERB(end)])
% xlim([-128.5 127.5])
% axis xy
% colorbar
% colormap('jet')
% xlabel('Modulation frequency')
% ylabel('Spectrum modulation')
