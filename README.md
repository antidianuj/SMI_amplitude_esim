
Keras implementation of identifying frquency and amplitude of displacement using self mixing interferometric (SMI) signals. The theme of this project can be shown as follows, where the arrow is to be approximated by some neural network.

![image](https://user-images.githubusercontent.com/47445756/233798112-5be89e87-1791-4380-8f43-4bbfcc18bb84.png)

In this repo, I constructed several deep learning architectures to map simulated self-mixing interferometric power signals to frequency and amplitude of the virating target. These architecture have 1D and 2D input topology. For 1D input topology the raw power signals are influxed into the model, but for the 2D case, the STFT spectrogram of the signal is used to convert the power signals in 2D format, as depicted below.
![image](https://user-images.githubusercontent.com/47445756/233847592-3d05c535-1b4e-4101-a1d2-bfa884c919d0.png)


Among all architectures, it was determined that 1D convolution architecture seems to work best for 1D signal data. Following shows the comparison of amplitude estimation error for all models.

![image](https://user-images.githubusercontent.com/47445756/233847464-360eb794-3a17-4d21-9da7-0df149946337.png)


Likewise, following is the comparison of distribution of frequency estimation error from the models.

![image](https://user-images.githubusercontent.com/47445756/233847499-7fc5dfc3-24e6-4915-afa1-68d8f72881f5.png)



