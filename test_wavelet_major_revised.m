%% ��������
% clear all 
tic
clc
tt=[buck100k(1:1:4096,1);buck100k1(1:1:4096,1);buck100k2(1:1:8192,1)];
VV=[buck100k(1:1:4096,2);buck100k1(1:1:4096,2);buck100k2(1:1:8192,2)];
II=[buck100k(1:1:4096,3);buck100k1(1:1:4096,3);buck100k2(1:1:8192,3)];
V=buck100k18(1:1:8192,2);
I=buck100k18(1:1:8192,3);
%% �������
% V=awgn(V1,40,'measured',9);
% I=awgn(I1,40,'measured',9);
%% ֱ������DWT������CS_DWTȥ��ʶESR�Ĳ��
% ESR=[];
% WESR=[];
% for tt=1:512:12288
%     V=VV(tt:1:tt+4095);
%     I=II(tt:1:tt+4095);
N=length(V);
% ����С���任����
ww=gen_dwt(N);
% ww=ConstructHaarWaveletTransformationMatrix(N);
%�任��Ľ��
WV_theta=ww*V;
WI_theta=ww*I;
% ѹ����֪��Ҫ�õ��Ĳ���
r=0.02;       % ѹ����
K=1;        % ϡ���
[theta_V]=compressed(V,r,K);
[theta_I]=compressed(I,r,K);
[WV_fs1,WV_fs2,WV_fs3,WV_fs4,WV_fs5,WV_fs6]=value_extract(WV_theta);
[WI_fs1,WI_fs2,WI_fs3,WI_fs4,WI_fs5,WI_fs6]=value_extract(WI_theta);
[V_fs1,V_fs2,V_fs3,V_fs4,V_fs5,V_fs6]=value_extract(theta_V);
[I_fs1,I_fs2,I_fs3,I_fs4,I_fs5,I_fs6]=value_extract(theta_I);
ESR1=V_fs1./I_fs1;    %CS_DWT ���  
WESR1=WV_fs1./WI_fs1; % DWT ���
WESR2=WV_fs2./WI_fs2; % DWT ���
% ESR=[ESR,ESR1];
% WESR=[WESR,WESR1];
% end
toc

%% ��ֵ����
function [value1,value2,value3,value4,value5,value6]=value_extract(x)
amp=abs(x);
amp(1)=[];    % ȥ����һ������ֵ
% [~,ii]=max(amp);
% amp(ii)=[];
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
end


%% ֱ����������Ʋ���ѹ�Ͳ����Ĺ�ϵȥ����ESR
% ֱ�Ӽ���ESR
% V0=mean(V);   %��ѹ��ֱ���ɷ�
% [V_D,k1]=max(V(1:80)); %���ݵ�ѹ�ڿ��عض�ʱ�̵�ֵ
% [V_0,k2]=min(V(1:80)); %���ݵ�ѹ�ڿ��ؿ���ʱ�̵�ֵ
% tt=t(k1)+(t(k1)-t(k2))./2;
% V_DT_0_5=V(find(roundn(t,-6)==roundn(tt,-6)));
% V_bar_D=V_D-V0;
% V_bar_0=V_0-V0;
% V_bar_DT_0_5=V_DT_0_5-V0;
% D=0.5;          %���ر�
% L=220*1e-6;     %���ֵ
% f=20*1e3;       %����Ƶ��
% ESR_directly_calculate=(V_bar_D-V_bar_0).*L*f/V0./D;
% C_directly_calculate=V0*(2*D-1)*(D-1)./(12*L*f^2)./(ESR_directly_calculate*V0*(D-1)./2./L./f-V_bar_0).*1e6;
% ESR_paper=2*L*f*(V_bar_0+(2*(2*D-1)/2-D)*V_bar_DT_0_5)./(V0*(D-1));
% C_paper=V0*(2-D)*(1-D)/(24*L*f^2*V_bar_DT_0_5).*1e6;