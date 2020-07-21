% 利用CS方法辨识boost电路的电解电容C和ESR的值
% clc 
% clear all
%% 加载数据
% fs=10008;     %采样频率
% N=5004;      %采样点数
% n=0:N-1;
% fn=n*fs/N;    %频率序列
V=boost1(1:1:4096,2);
I=boost1(1:1:4096,3);
% V=awgn(V1,40);
% I=awgn(I1,40);
% ESR 和 C值的提取
[V_fs1,V_fs2,V_fs3,V_fs4,V_fs5,V_fs6,thetaV]=value_extract(V);
[I_fs1,I_fs2,I_fs3,I_fs4,I_fs5,I_fs6,thetaI]=value_extract(I);
ESR1=V_fs1./I_fs1;
ESR2=V_fs2./I_fs2;
ESR3=V_fs3./I_fs3;
ESR4=V_fs4./I_fs4;
ESR5=V_fs5./I_fs5;
ESR6=V_fs6./I_fs6;
ESR=[ESR1,ESR2,ESR3];
ESR=mean(ESR)
esr1=value_extract1(V,I)
%% 作幅频图
amp=abs(thetaV);
N=length(thetaV);
n=0:N-1;
fs=500*N;     %采样频率  1600K 
fn=n*fs/N;    %频率序列
mag=amp/((N-1)/2);
% plot(fn,mag)
%%
function [value1,value2,value3,value4,value5,value6,theta]=value_extract(x)
% CS采样特征值
r=0.01;       % 压缩率
K=2;        % 稀疏度
[theta]=compressed(x,r,K);
%% FFT提取特征值
% [theta]=fft(x);
%% 数据处理
amp=abs(theta);
amp(1)=[];    % 去掉第一个幅度值
[value1,ij]=max(amp);
amp(ij)=[];
[value2,ik]=max(amp);
amp(ik)=[];
[value3,ip]=max(amp);
amp(ip)=[];
[value4,iq]=max(amp);
amp(iq)=[];
[value5,ir]=max(amp);
amp(ir)=[];
[value6,is]=max(amp);
% pha=angle(theta)/pi*180;%求相角
% value3=pha(ij);
end
%% DCT 
function C = gen_dct(n)
alp = [sqrt(1/n) sqrt(2/n)*ones(1,n-1)];
ind = (1:2:(2*n-1))*pi/(2*n);
C = zeros(n,n);
for k = 1:n
C(k,:) = alp(k)*cos((k-1)*ind);
end
end
%% 电容两端电压和流过电容电流在跃变处差值的比值
function [ESR]=value_extract1(V,I)
V=V(1:end);
Vp=max(V)-min(V);
I=I(1:1500);
Ip=max(I)-min(I);
ESR=Vp./Ip;
end
