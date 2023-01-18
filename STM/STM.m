function [stm,env] = STM(xt,fs,Cam,n)
if nargin<4, n = 15; end
[gtOut,~]=IIRGammaToneFB(xt,fs,Cam);
for i = 1:length(Cam)
    E = abs(hilbert(gtOut(i,:)'));
%     ReE(i,:) = resample(E,400,fs).^2;
%     env(i,:) = LPFilterFB(ReE(i,:),128,400);
    env(i,:) = resample(E,1000,fs).^2;
end
env(env<0) = 0.0;
L = 2^n;
stm = abs(fftshift(fft2(env,numel(Cam),L)));