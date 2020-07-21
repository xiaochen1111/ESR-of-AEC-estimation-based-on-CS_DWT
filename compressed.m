%% Compressed Sensing Method for IGBT High-Speed Switching Time On-Line Monitoring
function [theta]=compressed(s,r,K)
%% 输入输出函数
% s 原始信号
% n 噪声
% r 压缩率
% f=awgn(s,no,'measured',9);
f=s;
n=length(f);                   
m = double(int32(r*n)); 
%                    构造测量矩阵感知矩阵
% randn('state',3)
% Phi = sqrt(1/m) * randn(m,n);     % 感知矩阵（测量矩阵）   高斯随机矩阵  R＝normrnd(MU,SIGMA,m,n)：sigma 方差
Phi=eye(m,n);                      % 感知矩阵
% Phi=randi(m,n)-1; 
% Phi(find(Phi==0))=-1;
% Phi= double(int32(rand(m,n)>0.9));
% Phi = randn(m,n);
% Phi = orth(Phi')';
% Phi = (sqrt(n))*eye(m)*Phi;
% Phi = PartHadamardMtx( m,n );
% Phi =  BernoulliMtx( m,n );% 不满足RIP%
% Phi =PartFourierMtx( m,n );
% Phi  = ToeplitzMtx( m,n );   
f2 = Phi * f;                   % 通过感知矩阵获得测量值   mx1
% Psi =inv( fft(eye(n,n)));       % 傅里叶正变换，频域稀疏正交基（稀疏表示矩阵）
Psi=gen_dwt(n);
A=Phi*Psi';                         % m*n
%% 重建信号                 
%omp 重构
% theta=CS_OMP(f2,A,K);
% BP重构
% lamda = 0.007*sqrt(2*log(n));  
% theta =  BPDN_quadprog(f2,A,lamda);  
% CoSaMP重构
%  [ theta ] = CS_CoSaMP( f2,A,K );
% [ theta ] = CS_SWOMP( f2,A,30,0.9);
% sig3=real(ifft(full(theta)));
% Gradient Descent with Sparsification(GraDeS)
theta = CS_OMP(f2,A,K);  
% theta = IST_Basic(f2,A,K);
%%                          L1范数重构
%% 评价指标    
% CR=m/n;
% disp(['压缩率',num2str(CR)]);
% PRD=sqrt(sum((s'-sig3).^2)./sum(s'.^2));
% disp(['失真率',num2str(PRD)]);
% RMSE=sqrt(sum((s'-sig3).^2)./n);
% disp(['均方根误差',num2str(RMSE)]);
% sigpower=sum(abs(s).^2)/length(s);
% noisepower=sum(abs(sig3'-s).^2)/length(sig3'-s);
% SNR=10*log10(sigpower/noisepower);
% disp(['信噪比',num2str(SNR)])