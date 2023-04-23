
Keras implementation of identifying frquency and amplitude of displacement using self mixing interferometric signals. The theme of this project can be shown as follows, where the arrow is to be approximated by some neural network.

![image](https://user-images.githubusercontent.com/47445756/233798112-5be89e87-1791-4380-8f43-4bbfcc18bb84.png)


In this repo, I constructed several deep learning architectures to map simulated self-mixing interferometric power signals to frequency and amplitude of the virating target.

Among all architectures, it was determined that 1D convolution architecture seems to work best for 1D signal data. Following is the estimation error distribution on test dataset for amplitude and frequency estim respectively.

![image](https://user-images.githubusercontent.com/47445756/231600878-9cd1b6e5-da25-4052-ba2f-2386974eb980.png)


![image](https://user-images.githubusercontent.com/47445756/231601049-92947fec-1623-4ccc-8db7-6e4667894ad3.png)

