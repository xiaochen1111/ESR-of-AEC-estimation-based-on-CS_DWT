%% Compressed Sensing Method for IGBT High-Speed Switching Time On-Line Monitoring
function [theta]=compressed(s,r,K)
%% �����������
% s ԭʼ�ź�
% n ����
% r ѹ����
% f=awgn(s,no,'measured',9);
f=s;
n=length(f);                   
m = double(int32(r*n)); 
%                    ������������֪����
% randn('state',3)
% Phi = sqrt(1/m) * randn(m,n);     % ��֪���󣨲�������   ��˹�������  R��normrnd(MU,SIGMA,m,n)��sigma ����
Phi=eye(m,n);                      % ��֪����
% Phi=randi(m,n)-1; 
% Phi(find(Phi==0))=-1;
% Phi= double(int32(rand(m,n)>0.9));
% Phi = randn(m,n);
% Phi = orth(Phi')';
% Phi = (sqrt(n))*eye(m)*Phi;
% Phi = PartHadamardMtx( m,n );
% Phi =  BernoulliMtx( m,n );% ������RIP%
% Phi =PartFourierMtx( m,n );
% Phi  = ToeplitzMtx( m,n );   
f2 = Phi * f;                   % ͨ����֪�����ò���ֵ   mx1
% Psi =inv( fft(eye(n,n)));       % ����Ҷ���任��Ƶ��ϡ����������ϡ���ʾ����
Psi=gen_dwt(n);
A=Phi*Psi';                         % m*n
%% �ؽ��ź�                 
%omp �ع�
% theta=CS_OMP(f2,A,K);
% BP�ع�
% lamda = 0.007*sqrt(2*log(n));  
% theta =  BPDN_quadprog(f2,A,lamda);  
% CoSaMP�ع�
%  [ theta ] = CS_CoSaMP( f2,A,K );
% [ theta ] = CS_SWOMP( f2,A,30,0.9);
% sig3=real(ifft(full(theta)));
% Gradient Descent with Sparsification(GraDeS)
theta = CS_OMP(f2,A,K);  
% theta = IST_Basic(f2,A,K);
%%                          L1�����ع�
%% ����ָ��    
% CR=m/n;
% disp(['ѹ����',num2str(CR)]);
% PRD=sqrt(sum((s'-sig3).^2)./sum(s'.^2));
% disp(['ʧ����',num2str(PRD)]);
% RMSE=sqrt(sum((s'-sig3).^2)./n);
% disp(['���������',num2str(RMSE)]);
% sigpower=sum(abs(s).^2)/length(s);
% noisepower=sum(abs(sig3'-s).^2)/length(sig3'-s);
% SNR=10*log10(sigpower/noisepower);
% disp(['�����',num2str(SNR)])