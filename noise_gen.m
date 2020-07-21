function sn=noise_gen(L)
% L=500;  %仿真长度
d=[1 -1.5 0.7 0.1]; c=[1 0.5 0.2];  % 分子分母多项式系数
nd=length(d)-1 ;nc=length(c)-1;   %阶次
xik=zeros(nc,1);  %白噪声初值
ek=zeros(nd,1);
xi=randn(L,1);  %产生均值为0，方差为1的高斯白噪声序列

for k=1:L
    sn(k)=-d(2:nd+1)*ek+c*[xi(k);xik];  %产生有色噪声
    %数据更新
    for i=nd:-1:2
        ek(i)=ek(i-1);
    end
    ek(1)=sn(k);
    for i=nc:-1:2
        xik(i)=xik(i-1);
    end
    xik(1)=xi(k);
end
subplot(2,1,1);
plot(xi);
xlabel('k');ylabel('噪声幅值');title('白噪声序列');
subplot(2,1,2);
plot(sn);
xlabel('k');ylabel('噪声幅值');title('有色噪声序列');
end