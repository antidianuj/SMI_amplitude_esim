# deep_learning_project
Keras implementation of identifying frquency and amplitude of displacement using self mixing interferometric signals

In this repo, I constructed several deep learning architectures to map simulated self-mixing interferometric power signals to frequency and amplitude of the virating target.

Among all architectures, it was determined that 1D convolution architecture seems to work best for 1D signal data. Following is the estimation error distribution on test dataset for amplitude and frequency estim respectively.

![image](https://user-images.githubusercontent.com/47445756/231600878-9cd1b6e5-da25-4052-ba2f-2386974eb980.png)
