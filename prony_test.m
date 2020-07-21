%  Prony�㷨
clear all
clc
format long
%% ����׼��

% x=buck(183000:184000,2);
% t=1:1:1000;
f1 = 49;   
f2 = 51;   
t=0.00001:0.00001:0.01; 
load('voltage')
% x = 160*sin(2*pi*f1*t+pi/5)+150*exp(-3*t).*sin(2*pi*f2*t+pi/4);   
x=voltage(1:200:end,2)';
dt = 0.00001;   
N = length(x);   
pe = floor(N/2);  
%% ������������  
Re=zeros(pe+1,pe+1); 
for i = 2:pe+1   
    for j = 1:pe+1        
        for n = pe:N-1         
            Re(i,j) = Re(i,j)+x(n-j+2)*x(n-i+2);          
        end
    end
end
Re(1,:) = [];  
%% SVD_TLSȷ������p��a  
[U,S,V] = svd(Re);       %%%%%%����ֵ�ֽ� 
% ��pֵ   
% ����ȫ������ֵƽ����  
sum_all = 0;  
for i = 1:pe      
    sum_all = sum_all+S(i,i)^2;
end 
% ��һ����ֵAk/A ��pֵ 
sum_k = 0; 
k = 1;  
while 1 - sqrt(sum_k/sum_all) > 0.0000000000000000001 & i<=pe    
    sum_k = sum_k+S(k,k)^2;              
    %%%%%%%����k������ֵƽ����     
    k = k+1;   
end
p = k-1;
p=11;
% ��Sp����
Sp=zeros(p+1,p+1);                
%%%%%%s���ɣ�p+1��X��p+1��ά����Sp  
for j = 1:p      
    for i = 1:(pe+1-p)   
        Sp = Sp+S(j)^2*V(i:i+p,j)*V(i:i+p,j)'; 
    end
end

SS = zeros(pe,pe+1);
for i = 1:p     
    SS(i,i) = S(i,i);  
end
B = U*SS*V;

% ��Sp�����  
inv_Sp=inv(Sp);  
if isinf(inv_Sp(1,1)) == 1       
    inv_Sp = pinv(Sp); 
end  

% ��a  
a=inv_Sp(2:p+1,1)/inv_Sp(1,1);  

%% ��z  
y=[1 a'];  
z=roots(y);  
%% ��x�Ľ���ֵx_j   %��ǰp����ֵ���ڲ���ֵ x_j(1:p)  
x_j=zeros(N,1);  
for i = 1:p      
    x_j(i)=x(i); 
end  

%��x��N-p+1������ֵ x_j(p+1:N) 
for n = p+1:N  
    for i = 1:p      
        x_j(n)=x_j(n)-a(i)*x_j(n-i);   
    end
end

%% ��ͼ x��x_j  
  
plot(x,'k');  
hold on;
plot(x_j,'r'); 
hold off;  

%% ��ȡ b=inv(H)*Z'*x_j  

% ��ȡN X pάvandermode����Z  
Z=zeros(N,p); 
for i=1:N    
    Z(i,:)=z'.^(i-1);  
end  

%��ȡH  
H=zeros(p,p); 
for i=1:p       
    for j=1:p         
        m=(conj(z(i))*z(j));      
        H(i,j)=(m^N-1)/(m-1);    
    end
end

% ��ȡb 
b=inv(H)*Z'*x';  

%% �������Amp Ƶ��Fre ˥������Damp ��λ Pha   
for i = 1:p      
    Amp(i) = abs(b(i));    
    Fre(i) = atan(imag(z(i)/real(z(i))))/(2*pi*dt);      
    Damp(i) = log(abs(z(i)))*dt;    
    Pha(i) = atan(imag(b(i)/real(b(i)))); 
end