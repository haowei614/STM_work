import numpy as np
from scipy import signal
import CBGammatoneFB

def STM(xt,Fs,BW,n=14):
    IBW = 40
    n = int(n)

    # get spec from CB GammaTonefilter
    SkRe, cfLen = CBGammatoneFB.CBGammatone(xt,Fs,BW)
    logSk = np.zeros_like(SkRe)

    for i in range(cfLen):
        logSk[i,:] = np.sqrt(np.abs(signal.hilbert(SkRe[i,:])) ** 2)

    timeLen = 2 ** n
    numCh = 2 ** 8

    #2Dfft
    f = -np.finfo(float).tiny
    logSk[np.isinf(logSk)] = f
    nsk = signal.resample(logSk, int((Fs / 2) / IBW))
    fftq = np.fft.fft2(nsk,(numCh,timeLen))
    abfftq = np.abs(fftq)



    # if Ftype == 'plot':
    #     STM_plot(dwt, dwf, abfftq)
    # elif Ftype == 'None':
    #     pass
    # else:
    #     raise ValueError('Ftype should be "plot" or "None".')

    return abfftq, fftq