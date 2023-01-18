%% extract feature of real and fake in stm

%ADD2022
pathToDatabase = 'F:\ADD_train_dev';
trainProtocolFile = fullfile(pathToDatabase, '\ADD_train_dev','\label', '\train_label.txt');
devProtocolFile = fullfile(pathToDatabase, '\ADD_train_dev','\label', '\dev_label.txt');
evaProtocolFile = fullfile(pathToDatabase, '\eval_track1','\label.txt');


% feature configuration
window_length = 30; % ms
NFFT = 1024;        % FFT bins
no_Filter = 70;     % no of filters
no_coeff = 19;      % no of coefficients including 0'th coefficient
low_freq = 0;       % lowest frequency to be analyzed
high_freq = 4000;
Cam = 1.8:1:32.9;

% read train protocol
fileID = fopen(trainProtocolFile);
protocol = textscan(fileID, '%s%s%s%s%s%s%s');
fclose(fileID);

% get file and label lists
filelist = protocol{1};
labels = protocol{2};


% get indices of genuine and spoof files
genuineIdx = find(strcmp(labels,'genuine'));
spoofIdx = find(strcmp(labels,'fake'));

%% real
stm_genuineFeatureCell = cell(size(genuineIdx(1:1000)));
% parfor i=1:length(genuineIdx)
    parfor i=1:1000
    filePath = fullfile(pathToDatabase,'\ADD_train_dev','\train',filelist{genuineIdx(i)});
    [x,fs] = audioread(filePath);
    x = gpuArray(x);
    [stm,env] = STM(x,fs,Cam);
    stm_genuineFeatureCell{i} = stm;
    end
disp('Done!');
% save('stm_genuineFeatureCell','stm_genuineFeatureCell')
%% fake
    stm_spoofFeatureCell = cell(size(spoofIdx(1:1000)));
%     for i:length(spoofIdx)
        parfor i=1:1000
        filePath = fullfile(pathToDatabase,'\ADD_train_dev','\train',[filelist{spoofIdx(i)}]);
        [x,fs] = audioread(filePath);
        x = gpuArray(x);
        [stm,env] = STM(x,fs,Cam);
        stm_spoofFeatureCell{i} = stm; 
        end
    disp('Done!');
%     save('stm_spoofFeatureCell','stm_spoofFeatureCell')