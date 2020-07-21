% boost ��·��״̬�ռ䷽��ת��Ϊ���ݺ���
L=100e-3;
Sw=0.5;
R=20;
Rc=0.244;
C=220e-6;
Vin=35;
%%
A=[0,-1./L.*(1-Sw);R.*Sw./L./C./(Rc+R),-L-Rc.*R.*(1-Sw)./L./(Rc+R)];
B=[1./L;Rc.*R.*(1-Sw)./L./(Rc+R)];
C=[1,1];
D=0;
[b,a] = ss2tf(A,B,C,D);
G=35.*tf(b,a)
syms s
g=( 11.21.*s + 7.251)./( s^2 + 1.305.*s + 0.1123)
stepplot(G)
%% ���������Ĵ��ݺ���
numerator = Vin./Sw;
denominator = [L.*C./(Sw.^2),L./R./(Sw.^2),1];
sys = tf(numerator,denominator)
stepplot(sys)
%% ����Կ��Ʊ����Ĵ��ݺ���
numerator =[-L.*Vin./(Sw.^4)./R,Vin./(Sw.^2)];
denominator = [L.*C./(Sw.^2),L./R./(Sw.^2),1];
sys = tf(numerator,denominator)
stepplot(sys)
