import os
import numpy as np
from scipy.io import savemat
from scipy.io.wavfile import read
import STM

pathToDatabase = 'F:/asvspoof2017'
trainProtocolFile = os.path.join(pathToDatabase, 'protocol_V2', 'ASVspoof2017_V2_train.trn.txt')
devProtocolFile = os.path.join(pathToDatabase, 'protocol_V2', 'ASVspoof2017_V2_dev.trl.txt')
evaProtocolFile = os.path.join(pathToDatabase, 'protocol_V2', 'label.txt')

# read train protocol
with open(trainProtocolFile, 'r') as file:
    data = file.read().split('\n')
with open(trainProtocolFile) as f:
    data = f.readlines()

# # debug code
# print(f"Number of lines read: {len(data)}")
# if len(data) > 0:
#     print(f"First line of data: {data[0]}")

filelist = [line.split()[0] for line in data]
labels = [line.split()[1] for line in data]

# get indices of genuine and spoof files
genuineIdx = [i for i, label in enumerate(labels) if label == 'genuine']
spoofIdx = [i for i, label in enumerate(labels) if label == 'spoof']

# extract STM for genuine files
#stm_real_all = np.zeros((len(genuineIdx), 150, 513))

# test one signal
# for i, idx in enumerate(genuineIdx):
i=0
path_real = os.path.join(pathToDatabase, 'asvspoof2017-data', 'ASVspoof2017_V2_train', filelist[i])
fs, real_speech = read(path_real)
real_speech = real_speech.flatten()

fftq,abfftq = STM.STM(real_speech, fs, 150)



print(np.shape(fftq))

# stm_real_all[i, :, :] = stm_real
# print(stm_real.shape)
# print(stm_real_all.shape)
#
# # average of STM
# stm_real_all_mean = np.mean(stm_real_all, axis=0)
# print(stm_real_all_mean.shape)
# savemat('F:/STM_files/stm_fake_all.mat', {'stm_real_all2': stm_real_all})

# # extract STM for spoof files
# stm_fake_all = np.zeros((len(spoofIdx), 150, 513))
# for i, idx in enumerate(spoofIdx):
#     path_fake = os.path.join(pathToDatabase, 'asvspoof2017-data', 'ASVspoof2017_V2_train', filelist[idx])
#     fs, fake_speech = read(path_fake)
#     fake_speech = fake_speech.flatten()
#     T = len(fake_speech) / fs
#     stm_fake, _ = STM(fake_speech, fs, 150, 'None')
#     stm_fake_all[i, :, :] = stm_fake
#
# # average of STM
# stm_fake_all_mean = np.mean(stm_fake_all, axis=0)
#
# savemat('F:/STM_files/stm_fake_all.mat', {'stm_fake_all2': stm_fake_all})
#del stm_fake_all