clear all;
close all;
clc;
t=0:1/1000:10;
y=10*t+2; % reference function
yi=[y(1),y(100),y(800)];% samples
ti=[t(1),t(100),t(800)]; % samples
iter=1000; % number of iteration
learn=0.1; %learning rate
m=0; %initial value
c=0; %initial value
for n=1:iter
   m=m-learn*dot((yi-m*ti-c),(-ti));
   c=c+learn*(sum((yi-m*ti-c)));
end
fat=polyfit(ti,yi,1)
disp(m);
disp(c);