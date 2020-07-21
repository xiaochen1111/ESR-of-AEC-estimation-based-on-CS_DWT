function [zStable]=alpha(al,beta,gamma,u)
%% 初始化

w=random(' exp ',1,3001,1);
theta=random(' Uniform ',-pi./2,pi./2,3001,1);

%% a稳定分布的求
zSaS=SaS(al,w,theta);
zStable=Stable(al,beta,gamma,u,w,theta);

%% 作图与验证
% 
% [muHat,sigmaHat] = normfit(zSaS);
% figure 
% histfit(zSaS)
% figure
% plot(zStable)
% set(gca,'FontSize',8,'FontName','Times New Roman')
% ylabel('signal','FontSize',8,'FontName','Times New Roman')
% xlabel('Data','FontSize',8,'FontName','Times New Roman')
% set(gcf,'units','centimeters','Position',[1,1,20,14]);
% title(['sigma=',num2str(sigmaHat)])
% grid on 
% figure
% normplot(zStable)
% grid on 


%% 子程序
% SaS 稳态分布
function z=SaS(alpha,w,theta)
z=(sin(alpha.*theta)./(cos(theta).^(1./alpha))).*(cos((alpha-1).*theta)./w).^((1-alpha)./alpha).*(alpha~=1)+tan(theta).*(alpha==1);
end
% 任何稳态分布
function x=Stable(alpha,beta,gamma,u,w,theta)
theta0=atan(beta.*(tan(pi.*alpha./2)))./alpha;
A=sin(alpha.*(theta0+theta))./((cos(alpha.*theta0).*cos(theta)).^(1./alpha));
z=A.*((cos(alpha*theta0+(alpha-1).*theta)./w).^((1-alpha)./alpha)).*(alpha~=1)+...
pi/2*(((pi/2+beta.*theta).*tan(theta)-beta.*log(pi/2.*w.*cos(theta)./(pi/2+beta.*theta)))).*(alpha==1);
 x=gamma*z+u;
end
end





















