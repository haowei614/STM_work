import numpy as np
import matplotlib.pyplot as plt

import STM


def STM_plot(dwt,dwf,abfftq):
    nb = abfftq.shape[0]
    fftq = STM.STM()
    lSTM = fftq.shape[1]
    # yaxis
    #cyc_Hz = IBW * nb
    cyc_Hz = 40
    dwf = np.arange(-(np.ceil((nb + 1) / 2) - 1) * (1 / cyc_Hz),
                    (np.ceil((nb + 1) / 2) - 1) * (1 / cyc_Hz) + 1e-10, 1 / cyc_Hz)

    # xaxis
    dwt = np.zeros(lSTM)
    for it in range(1, np.ceil(lSTM / 2) + 1):
       # dwt[it - 1] = it * (Fs / lSTM)
        dwt[it - 1] = it * (16000 / lSTM)
        if it > 1:
            dwt[lSTM - it] = -dwt[it - 1]

    STMxarea = 80
    STMyarea = 3.5
    fig1 = plt.figure(1)
    plt.set_cmap('jet')
    # ax = fig1.add_subplot(111)
    plt.imshow(np.fft.fftshift(abfftq) , extent = [np.min(dwt), np.max(dwt), np.min(dwf)*1000, np.max(dwf)*1000])
    plt.title('Spectrum Temporal Modulation')
    plt.axis('xy')
    plt.axis([-STMxarea, STMxarea, 0, STMyarea])
    plt.xlabel('Temporal Modulation (Hz)')
    plt.ylabel('Spectral Modulation (cycl/kHz)')
    plt.colorbar()
    plt.gca().tick_params(axis='both', labelsize=15)
    plt.show()

