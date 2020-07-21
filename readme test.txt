clc
clear all
%加载原始数据
load('boosttest1.mat');
load('boosttest2.mat');
load('boosttest3.mat');
% i=451000:452023;
% j=450963:451986;
% k=450979:452002;
% m=450969:451992;
% n=451020:452043;
i=1:1:1000;
y=boosttest1(i);
y1=boosttest2(i);
y2=boosttest3(i);
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
% yw=awgn(y, w,'measured', 10);
% yw1=awgn(y1,w,'measured',10);
% yw2=awgn(y2,w,'measured',10);
% yw3=awgn(y3,w,'measured',10);
% yw4=awgn(y4,w,'measured',10);
% for K=2:2:169
K=164;                    %70;124
% yw5=y5+w;
sig=compressed(y,r,K);
sig1=compressed(y1,r,K);
sig2=compressed(y2,r,K);
% sig3=compressed(yw3,r,K);
% sig4=compressed(yw4,r,K);
% sig5=compressed(y5,w,r,K);
%% 特征提取
% PCA
[pcaout]=feaext(sig);
[pcaout1]=feaext(sig1);
[pcaout2]=feaext(sig2);
% [pcaout3]=time_feaext(yw3);
% [pcaout4]=time_feaext(yw4);
% [pcaout4]=feaext(yw1);
% [pcaout5]=feaext(yw2);

%% 评价指标
D=evalution(pcaout2,pcaout1);
D1=evalution(pcaout,pcaout2);
% D2=evalution(pcaout,pcaout3);
% D3=evalution(pcaout,pcaout4);
pca=[pca,D(2,:)];
pca1=[pca1,D1(2,:)];
% pca2=[pca2,D2(2,:)];
% pca3=[pca3,D3(2,:)];
d1=abs(mean(pcaout2)-mean(pcaout1));
d2=abs(mean(pcaout2)-mean(pcaout1));
dd=[d1,d2];
smooth1=sqrt(sum(diff(pcaout2).^2)./(8*(min(dd).^2)));
smooth=[smooth,smooth1];
% end
%%
% sigpower=sum(abs(y).^2)/length(y);
% noisepower=sum(abs(sig-y).^2)/length(sig-y);
% SNR=10*log10(sigpower/noisepower);
% S=[S,SNR];
% % disp(['信噪比',num2str(SNR)])
% PRD=sqrt(sum((y-sig).^2)./sum(y.^2));
% P=[P,PRD];
% % disp(['失真率',num2str(PRD)]);
% RMSE=sqrt(sum((y-sig).^2)./1024);
% R=[R,RMSE]
% % disp(['均方根误差',num2str(RMSE)]);