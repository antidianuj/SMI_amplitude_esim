lambda = 0.785;
s=4/pi*lambda;
xc_estim=-xc_estim;
[dsig,dsig2]=wavedenoiser_alphy1(xc_estim,10);%My wavelet denoiser function
d_ex=s*transpose(dsig2);%calculated displacement form X0
%dsig3=J_filter_alphy1(time,dsig2,10);
err=abs(Displ-d_ex);

subplot(4,1,1)
plot(time,Displ);
title('Target Vibration');

subplot(4,1,2)
plot(time,xc_estim);
title('Perturbed Phase');

subplot(4,1,3)
plot(time,d_ex);
title('Wavelet denoised extracted displacement');

subplot(4,1,4)
plot(time,err);
title('Error');