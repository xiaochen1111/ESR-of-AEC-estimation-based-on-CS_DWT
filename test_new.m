x=test(1:end,3);
N=3205;      %���ݵ���
fs=500*N;    %����Ƶ��
n=0:N-1;      
t=n./fs;
% x=10*sin(2*pi*120*t+pi./4);
fn=n*fs/N;  %Ƶ������
% y=fft(x,N);%����fft�任
    y = zeros(1,N);    
    for k=1:N
        sn =0.0;
        for i=1:N
            sn = sn+x(i)*exp(-1i*2*pi*i*k/N);
        end
        y(k) = sn;
    end
%
mag=abs(y);%���ֵ��abs�����źŵ�ģ
% tol = 0.4;
% y(abs(y) < tol) = 0;
pha=angle(y)/pi*180;%�����
figure(1);
plot(fn(1:N/2),mag(1:N/2)*2/N); %��ķ�Ƶ��������
grid;
xlabel('Ƶ��/Hz');
ylabel('���');
title('FFT�任��ķ�Ƶ��������');

figure(2);
plot(fn(1:N/2),pha(1:N/2));%%FFT�任�����Ƶ��������
grid;
xlabel('Ƶ��/Hz');
ylabel('��λ');
title('FFT�任�����Ƶ��������');



%% ����C��ESR
%  xn���źţ�n�����꣬N�ǵ���
 N =8;
 n = [0:1:N-1];
 xn = 0.5.^n;        % ָ���ź�
% function [] = DFTusefft(xn,n,N)
    figure(1);
    y=fft(xn,N);      % ����Ҷ�任
    subplot(211);
    stem(n,xn);
    title('ԭ�ź�');

    subplot(212);
    stem(n,abs(y));
    title('FFT�任')
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
    title('ԭ�ź�');

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
subplot(211);plot(t,x);title('ԭʼ�ź�'),xlabel('ʱ��/t');
f=(0:N-1)/(N*dt);
subplot(212);plot(f,y);hold on
title('Fourier');xlabel('Ƶ��/HZ');ylabel('���');
ind=find(y==max(y),1,'first');%Ѱ�����ֵ��λ��
%%%%%%% ind = find(X, k) ��ind = find(X, k, 'first')
%   ���ص�һ������Ԫ��k������ֵ��˳�򣩡�
%   k������һ���������������������κ�������ֵ���͡�

x0=f(ind); %����λ�õõ������꣨Ƶ�ʣ�
y0=y(ind); %����λ�õõ������꣨���ȣ�
plot(x0,y0,'ro');hold off

%%%%%%% hold on ��hold off�������ʹ�õ�.ͨ����һ��ͼ�ϻ��������߽��бȽϡ�
%   ǰ�ߵ���˼�ǣ����ڵ�ǰͼ���ᣨ����ϵ���л���һ��ͼ���ٻ���һ��ͼʱ��ԭ����ͼ���ڣ�����ͼ���棬�����õ�
%   ���߱����ǣ����ڵ�ǰͼ���ᣨ����ϵ���л���һ��ͼ����ʱ��״̬��hold off,���ٻ���һ��ͼʱ��ԭ����ͼ�Ϳ������ˣ������ϻ��Ƶ�����ͼ��ԭͼ���滻��

text(x0+1,y0-0.1,num2str(x0,'Ƶ��=%f'));

%   text(x,y,'string')��ͼ����ָ����λ��(x,y)����ʾ�ַ���string