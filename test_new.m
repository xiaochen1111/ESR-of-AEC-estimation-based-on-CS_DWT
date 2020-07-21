x=test(1:end,3);
N=3205;      %数据点数
fs=500*N;    %采样频率
n=0:N-1;      
t=n./fs;
% x=10*sin(2*pi*120*t+pi./4);
fn=n*fs/N;  %频率序列
% y=fft(x,N);%进行fft变换
    y = zeros(1,N);    
    for k=1:N
        sn =0.0;
        for i=1:N
            sn = sn+x(i)*exp(-1i*2*pi*i*k/N);
        end
        y(k) = sn;
    end
%
mag=abs(y);%求幅值，abs：求信号的模
% tol = 0.4;
% y(abs(y) < tol) = 0;
pha=angle(y)/pi*180;%求相角
figure(1);
plot(fn(1:N/2),mag(1:N/2)*2/N); %后的幅频特性曲线
grid;
xlabel('频率/Hz');
ylabel('振幅');
title('FFT变换后的幅频特性曲线');

figure(2);
plot(fn(1:N/2),pha(1:N/2));%%FFT变换后的相频特性曲线
grid;
xlabel('频率/Hz');
ylabel('相位');
title('FFT变换后的相频特性曲线');



%% 计算C和ESR
%  xn是信号，n是坐标，N是点数
 N =8;
 n = [0:1:N-1];
 xn = 0.5.^n;        % 指数信号
% function [] = DFTusefft(xn,n,N)
    figure(1);
    y=fft(xn,N);      % 傅立叶变换
    subplot(211);
    stem(n,xn);
    title('原信号');

    subplot(212);
    stem(n,abs(y));
    title('FFT变换')
% end
%%
    y = zeros(1,N);    
    for k=1:N
        sn =0.0;
        for i=1:N
            sn = sn+xn(i)*exp(-1i*2*pi*i*k/N);
        end
        y(k) = sn;
    end
    figure(2);
    subplot(211);
    stem(n,xn);
    title('原信号');

    subplot(212);
    stem(n,abs(y));
    title('DFT')
%%
clear all;
N=256;dt=0.02;
n=0:N-1;t=n*dt;
x=sin(2*pi*t);
a=zeros(1,N);b=zeros(1,N);
for k=0:N-1
    for ii=0:N-1
        a(k+1)=a(k+1)+2/N*x(ii+1)*cos(2*pi*k*ii/N);
        b(k+1)=b(k+1)+2/N*x(ii+1)*sin(2*pi*k*ii/N);
    end
y(k+1)=sqrt(a(k+1)^2+b(k+1)^2);
end
subplot(211);plot(t,x);title('原始信号'),xlabel('时间/t');
f=(0:N-1)/(N*dt);
subplot(212);plot(f,y);hold on
title('Fourier');xlabel('频率/HZ');ylabel('振幅');
ind=find(y==max(y),1,'first');%寻找最大值的位置
%%%%%%% ind = find(X, k) 或ind = find(X, k, 'first')
%   返回第一个非零元素k的索引值（顺序）。
%   k必须是一个正数，但是它可以是任何数字数值类型。

x0=f(ind); %根据位置得到横坐标（频率）
y0=y(ind); %根据位置得到纵坐标（幅度）
plot(x0,y0,'ro');hold off

%%%%%%% hold on 和hold off，是相对使用的.通常是一个图上画两个曲线进行比较。
%   前者的意思是，你在当前图的轴（坐标系）中画了一幅图，再画另一幅图时，原来的图还在，与新图共存，都看得到
%   后者表达的是，你在当前图的轴（坐标系）中画了一幅图，此时，状态是hold off,则再画另一幅图时，原来的图就看不到了，在轴上绘制的是新图，原图被替换了

text(x0+1,y0-0.1,num2str(x0,'频率=%f'));

%   text(x,y,'string')在图形中指定的位置(x,y)上显示字符串string