clc
clear all
%加载原始数据
load('boost1.mat');


i=451000:451920;
j=450963:451883;
k=450979:451899;
m=450969:451889;
n=451020:451940;

y=boost1(i,1);
y1=boost1(j,2);
y2=boost1(k,3);
y3=boost1(m,4);
y4=boost1(n,5);
cspca=[];

w=45;               %信噪比
r=0.5;
pca=[];
pca1=[];
pca2=[];
pca3=[];
smooth=[];
%%
% for r=0.3:0.1:0.8
% for w=30:5:65
yw=awgn(y, w,'measured', 10);
yw1=awgn(y1,w,'measured',10);
yw2=awgn(y2,w,'measured',10);
yw3=awgn(y3,w,'measured',10);
yw4=awgn(y4,w,'measured',10);

%%
i=1:1:92;
y=y(i);
yw=yw(i);                                                                     %采样率
N  =92;                                                                        %采样点数
fs=50000;
fax=(0:N-1)/N*fs;
w=hann(92);
k=fft(yw,N);
yyw=db(fftshift(fft(yw)));
yyw=yyw.*w;
plot(fax,yyw);
yy=db(fftshift(fft(y)));
yy=yy.*w;
hold on
plot(fax,yy);
%% 
figure
b = fir1(92,[0.48 0.52],'bandpass');
freqz(b,1,512)
y=filter(b,1,yw);
%%
% load officetemp
% 
% tempC = (temp-32)*5/9;
% 
tempnorm = yw4;

fs = 50000;
t = (0:length(tempnorm) - 1)/fs;

plot(t,tempnorm)
xlabel('Time (days)')
ylabel('Temperature ( {}^\circC )')
axis tight
%%
 for j=1:99:3500
    i=j+55:1:j+61;
    controlsignal(i)=[];
 end