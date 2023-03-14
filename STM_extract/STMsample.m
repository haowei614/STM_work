%  This program is make STM: Spectrum Temporal Modulation
%  Author:	 Soichiro TANAKA from JAIST Unoki lab
%  Created: 25 Aug. 2021
%  Updated: 15 Aug. 2021
%    
%  INPUTS  :	
%  Fs	   : Sampling frequency (Hz)
%  BW      : Band Width of CBCammaTone Filter Bank (Hz) (defult: 160)
%  IBW     : Imaginary Band Width of CBCammaTone Filter Bank (Hz) (defult: 40)
%  Twideth : Taper Sec (msec) (defult: 150)   
%
%%
clear
close all

%%%%%%%%%% Parameter setting %%%%%%%%%%		1,3,4
BW=150;                      
IBW=40;
%Twideth=300;   

%%%%%%%%%% Data-read %%%%%%%%%%
%ASV2017
pathToDatabase = 'F:\asvspoof2017';
trainProtocolFile = fullfile(pathToDatabase, '\protocol_V2','\ASVspoof2017_V2_train.trn.txt');
devProtocolFile = fullfile(pathToDatabase, '\protocol_V2','\ASVspoof2017_V2_dev.trl.txt');
evaProtocolFile = fullfile(pathToDatabase, '\protocol_V2','\label.txt');

% read train protocol
fileID = fopen(trainProtocolFile);
protocol = textscan(fileID, '%s%s%s%s%s%s%s');
fclose(fileID);
filelist = protocol{1};
labels = protocol{2};

% get indices of genuine and spoof files
genuineIdx = find(strcmp(labels,'genuine'));
spoofIdx = find(strcmp(labels,'spoof'));
i=1;
path_real = fullfile(pathToDatabase,'\asvspoof2017-data','\ASVspoof2017_V2_train',filelist{genuineIdx(i)});
path_fake = fullfile(pathToDatabase,'\asvspoof2017-data','\ASVspoof2017_V2_train',filelist{spoofIdx(i)});
%filename = 'test';
[xt0,Fs] = audioread(path_real);

%xt0 = resample(xt0,44100,Fs);
n=0;
xt0=xt0.';
T = length(xt0)/Fs;

%%
%get spec from CB GammaTonefilter
[SkRe,~,t,cf,cfLen,Phk]=CBGammaToneFBc(xt0,Fs,BW,'OFF');

for i = 1:cfLen
    logSk(i,:)=sqrt(abs(hilbert(SkRe(i,:))).^2);
end
clear SkRe;
clear SkIm;

%2Dfft
f = (-realmin('double'));
logSk(find(isinf(logSk)))=f;
nsk=resample(logSk,fix((Fs/2)/IBW),cfLen);
fftq=fft2(nsk);
abfftq=((abs(fftq)));

nb = size(abfftq,1);
lSTM = size(fftq,2);

%yaxis
cyc_Hz = IBW*nb;
dwf = -(ceil((nb+1)/2)-1)*(1/cyc_Hz):1/cyc_Hz:(ceil((nb+1)/2)-1)*(1/cyc_Hz);
%xaxis1
% mod_f = (1/Fs)*lSTM;
% dwt2 = -(ceil((lSTM)/2))*(Fs/lSTM)+1/mod_f:1/mod_f:(ceil((lSTM)/2))*(Fs/lSTM)-1/mod_f;
% aaaa = -Fs/2:1/T:Fs/2;

%xacis2
for it=1:ceil((lSTM)/2)
    dwt(it) = (it)*(Fs/lSTM);
    if (it > 1 )
        dwt(lSTM-it) = -dwt(it);
    end
end
%%%%%%%%%%%%%%% STM plot %%%%%%%%%%%%%%% 
%%
STMxarea=80;
STMyarea=3.5;

fig1=figure(1);
colormap('jet')
ax = axes;
imagesc(fftshift(dwt),dwf.*1000,fftshift(abfftq));
%imagesc(fftshift(dwt),fftshift(dwf).*1000,20*log10(fftshift(abfftq)));
title('Spectrum Temporal Modulation');
axis xy;
axis([-STMxarea STMxarea 0 STMyarea]);
xlabel('Temporal Modulation (Hz)');
ylabel('Spectral Modulation (cycl/kHz)');
colorbar;
set(gca,'FontSize',15)
caxis([0 1*10^4]);


fig2=figure(2);
imagesc(t,cf,nsk);
axis xy
colorbar
colormap('jet')
xlabel('Time [sec]')
ylabel('Frequency [Hz]')
set(gca,'FontSize',15)
% % caxis([0 10^4]);
xlim([0 0.5])

%%%%%%%%%対数スケールのカラーバー%%%%%%%%%%
%  fig6=figure(6);
% tk = logspace(2,5,100);
% cmap = jet(99);
% ctable = [tk(1:end-1)' cmap*255 tk(2:end)' cmap*255];
% ax = axes;
% imagesc(dwt2,dwf.*1000,(fftshift(abfftq)));
% title('Spectrum Temporal Modulation');
% axis xy;
% axis([-STMxarea STMxarea 0 STMyarea]);
% xlabel('Temporal Modulation (Hz)');
% ylabel('Spectral Modulation (cycl/kHz)');
% colorbar;
% cptcmap('mycol', 'mapping', 'direct');
% cptcbar(gca, 'mycol', 'eastoutside', false);

saveas(fig1,['./figure/' filename '_STM.png'])
saveas(fig2,['./figure/' filename '_Spec.png'])
% saveas(fig3,['./figure/' filename '_halfSpec.png'])
% saveas(fig4,['./figure/' filename '_TM0.png'])
% save('.mat','r')
%
