
function yout=gen_suv(ynew,yin)
% yin 原始信号
% ynew 重构之后的信号 
s=yin;
y=ynew;
N=length(y);
% subplot(4,1,1); plot(s,'LineWidth',1.5)
% title('原始模拟信号 ','FontSize',16)
% set(gca,'box','off')
% %set(gca,’linewidth’,1.5);
% subplot(4,1,2); plot(y,'LineWidth',1.5)
% title('原始模拟信号+高斯噪声','FontSize',16)
% set(gca,'box','off')
%set(gca,’linewidth’,1.5);
%%
%===== 傅里叶变换结果 ====
% NFFT = 2^nextpow2(N); % Next power of 2 from length of y
% Y = fft(y,NFFT)/N;
% f = N/2*linspace(0,1,NFFT/2+1);
% subplot(4,1,3);plot(f,4*abs(Y(1:NFFT/2+1)),'LineWidth',1.5) %查看信号的频谱，因为奇异值去噪一般选择2*信号主频的个数
% title('频率 ','FontSize',16)
% set(gca,'box','off')
%set(gca,’linewidth’,1.5);

n=8;

%=============================
%==== 奇异值分解 ====
%%
for i=1:N/2+1
t=i:i+N/2-1;
for j=1:N/2
A(j,i)=y(t(j)); %把一维信号重构为矩阵做奇异值分解
end
end
[U,S,V] = svd(A);

%=============================
%==== 重构信号 =====
X=zeros(size(A));
for i=1:n;%选取前n个大奇异值
X=X+U(:,i)*S(i,i)*V(:,i)';
end
yout=zeros(1,N);
for i=1:N
a=0;m=0;
for j1=1:N/2
for j2=1:N/2+1
if i+1==j1+j2
a=a+X(j1,j2); %把矩阵重构回一维信号
m=m+1;
end
end
end
yout(i)=a/m;
end
% JG(N/2+1:end)=X(:,end);
%%
% %%%%%%%%%%%%%画图%%%%%%%%%%%%%%%%%%%%%%%%%
% subplot(4,1,4);plot(yout,'LineWidth',1.5)
% title('奇异值降噪信号','FontSize',16)
% xlabel('时间','FontSize',16)
% set(gca,'box','off')
% %set(gca,’linewidth’,1.5);
% set(gcf,'color','w')

