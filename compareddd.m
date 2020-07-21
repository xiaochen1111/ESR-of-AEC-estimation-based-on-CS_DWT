clc
clear all
load('compared.mat');
i =1:1:1400;
esr=[];
c=[];
for k=1:1:5
y=compared(i,k);
% y1=compared(i,2);
% y2=compared(i,3);
% y3=compared(i,4);
% y4=compared(i,5);
[ESR,C]=estimation(y);
esr=[esr,ESR];
c=[c,C];
end
%% 
x=1:1:10;
figure
stairs(x,c(:,1),'g','linewidth',1.8)
hold on
stairs(x,c(:,2),'b','linewidth',0.5)
hold on
stairs(x,c(:,3),'m','linewidth',0.5)
hold on
stairs(x,c(:,4),'r','linewidth',0.5)
hold on
stairs(x,c(:,5),'k','linewidth',1.5)
% axis([0 499 10.456 10.9])
legend('state 1','state 2','state 3','state 4','state 5');
ylabel('Ripple voltage(V)')
xlabel('Time(us)')
set(gca,'FontSize',12);
set(gca,'FontName','Helvetica');%%设置所有字体大小为18号，字体为Helverica
set(gca,'linewidth',1.5);%%设置图框的线宽
set(gcf,'position',[0 0 650 450]);%%设置画幅大小为横650*纵450
set(gca,'xtick',[0,50,50*2,50*3,50*4,50*5,50*6,50*7,50*8,50*9,50*10]);
set(gca,'xticklabel',{'0','25','50','75','100','125','150','175','200','225','250'});
function [ESR,C]=estimation(y)
t=92:93:962;
t1=112:93:950;
V00=y(t);
% V00=mean(V00);
V2=y(t1);
% V2=mean(V2);
L=30*1e-6;
D=9./25;
f=40*1e3;
V0=[];
for t=92:93:962;
kk=t:1:t+93;
yy=y(kk);
V=mean(yy);
V0=[V0,V];
end
V0=V0';
ESR=2*L*f*((V00-V0)+2.*(2*D-1)./(2-D).*(V2-V0))./(V0.*(D-1));
C=V0*(2-D)*(1-D)./(24*L*f.^2*(V0-V2))*1e6;
end
