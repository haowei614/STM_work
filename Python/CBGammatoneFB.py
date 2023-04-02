import numpy as np
from scipy import signal
  
def CBGammatone(data,fs,BW):
    # CBGammatoneFB: Constant Bandwidth GammaTone FilterBank
    data = np.array(data)
    if data.ndim>1:
        data = np.squeeze(data)
    #Parameter setting (CBFB)
    fL = 0   # Low limitation of the filterbank
    fH = fs / 2  # Upper limitation of the filterbank
    cf = np.arange(fL + BW / 2 , fH - BW / 2 + BW, BW)
    cfLen = cf.shape[0]
    xtLen = data.shape[0]

    # Constant Bandwidth GammaTone FilterBank
    SkRe = np.zeros((cfLen, xtLen))
    SkIm = np.zeros((cfLen, xtLen))
    Phk = np.zeros((cfLen, xtLen))

    delaySmp = np.fix(3 * fs / (2 * np.pi * BW)).astype(int)  # length of group delay
   # t = np.arange(0,xtLen/fs, 1/fs)  # time sample
    tau = np.arange(0, 0.1, 1/fs)  # time sample of the gammatone(winlength)

    for nch in range(cfLen):
        gm = GammaTone(tau, cf[nch], 1.0, 'real')
        gtoutRe = (1 / fs) * signal.convolve(gm, data)
        SkRe[nch, :] = gtoutRe[delaySmp + 1:xtLen + delaySmp + 1]
        # gtoutIm = (1 / fs) * signal.convolve(gm, data)
        # SkIm[nch, :] = gtoutIm[1 + delaySmp:xtLen + delaySmp]
        # Phk[nch, :] = np.unwrap(np.arctan2(SkIm[nch, :], SkRe[nch, :])) - 2 * np.pi * cf[nch] * t

    return SkRe, cfLen

def GammaTone(t,f0,bCoef=1.0,Ftype='real'):
    _,ERBw = Freq2ERB(f0)
    if Ftype != 'real' and Ftype != 'imag' and Ftype != 'complex':
        raise ValueError('Ftype must be real, imag or complex')
    n = 4
    bERB = bCoef * ERBw
    N = 1
    # fbre = np.zeros_like(t)

    for k in range(n-1,0,-1):
        N *= k
    amp = 2 * (2 * np.pi *bERB) ** n / N

    if Ftype == 'real':
        gt = amp * (t ** (n - 1)) * np.exp(-2 * np.pi * bERB * t) * np.cos(2 * np.pi * f0 * t)
    elif Ftype == 'imag':
        gt = amp * (t ** (n - 1)) * np.exp(-2 * np.pi * bERB * t) * np.sin(2 * np.pi * f0 * t)
    elif Ftype == 'complex':
        gt = amp * (t ** (n - 1)) * np.exp(-2 * np.pi * bERB * t) * np.exp(1j * 2 * np.pi * f0 * t)
    return gt

def Freq2ERB(Frs):
    if Frs > 12000 or Frs < 50:
        raise ValueError('Frequency must be between 50 and 12000 Hz')
    # cfmin = 50
    # cfmax = 12000
    Fkhz = Frs / 1000
    ERBrates = 21.4 * np.log10(4.37 * Fkhz + 1)
    ERBwidthes = 24.7 * (4.37 * Fkhz + 1 )

    return ERBrates,ERBwidthes
