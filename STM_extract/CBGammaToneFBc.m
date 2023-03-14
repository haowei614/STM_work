%
%	CBGammaToneFBc: Constant-Band GammaTone FilterBank
%
%	function [Sk,Phk,cf]=CBGammaToneFB(data,NumCh,fs,swOPmode)
%
%	INPUTS:	data	: Input data
%		NumCh	: Channel number
%		fs	: Sampling frequency (Hz)
%		swOPmode: Operation show mode ('ON' or 'OFF')
%	OUTPUT	Sk	: Filterbank output 
%		Phk	: Phase
%		cf	: Center frequency (Hz)
%
%	Author:	 Masashi UNOKI
%	Created: 15 Apr. 2001
%	Updated: 14 Aug. 2002
%	Copyright (c) 2001, 2002, CNBH, Univ. of Cambridge / Akagi-lab. JAIST

function [SkRe,SkIm,t,cf,cfLen,Phk]=CBGammaToneFBc(data,fs,BW,swOPmode)
if nargin < 1, help CBGammaToneFBc, return; end; 
if nargin < 2, NumCh=500; end;
if nargin < 3, fs=20000; end; 
if nargin < 4, swOPmode='ON'; end; 

%%%%%%%%%%%%%%%%%%%% Parameter settings (CBFB) %%%%%%%%%%%%%%%%%%%%

fL=0;				% Lower limitation of the filterbank
fH=fs/2;			% Upper limitation of the filterbank
cf=fL+BW/2:BW:fH-BW/2;		% 
cfLen=length(cf);		% 
data=data(:)'; 			% reshape of data
xtLen=length(data);		% length of signal

%%%%%%%%%%%%%%%%%%%% Constant Bandwidth GammaTone FilterBank %%%%%%%%%%%%%%%%%%
SkRe=zeros(cfLen,xtLen);
SkIm=zeros(cfLen,xtLen);
Phk=zeros(cfLen,xtLen);

delaySmp=fix(3*fs/(2*pi*BW));		% length of group delay
t=0:1/fs:(xtLen-1)/fs;			% time sample
tau=0:1/fs:0.1;				% time sample of the gammatone(winlength)

for nch=1:cfLen;
   gtoutRe = (1/fs)*cconv(GammaTone(tau,cf(nch),1.0,BW,fs,'real'),data);
   SkRe(nch,:) = gtoutRe(1+delaySmp:xtLen+delaySmp);
   gtoutIm = (1/fs)*cconv(GammaTone(tau,cf(nch),1.0,BW,fs,'imag'),data);
   SkIm(nch,:) = gtoutIm(1+delaySmp:xtLen+delaySmp); 
   Phk(nch,:)=unwrap(atan2(SkIm(nch,:),SkRe(nch,:)))-2*pi*cf(nch)*t;
%  Phk(nch,:)=unwrap(angle(hilbert(SkRe(nch,:))))-2*pi*cf(nch)*t;
  
  end;

%save memory
%clear SkRe ;
%clear SkIm;
clear data ;
clear xtLen;
clear nch;
clear tau;
clear Sk;
return


