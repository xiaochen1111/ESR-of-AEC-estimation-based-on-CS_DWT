function [ x ] = IST_Basic( y,Phi,lambda,epsilon,loopmax )
%   Detailed explanation goes here  
%Version: 1.0 written by jbb0523 @2016-08-09 
%Version: 1.1 modified by jbb0523 @2016-08-12 
    if nargin < 5    
        loopmax = 10000;    
    end    
    if nargin < 4      
        epsilon = 0.1;      
    end     
    if nargin < 3      
        lambda =0.015*max(abs(Phi'*y));     
    end     
    [y_rows,y_columns] = size(y);      
    if y_rows<y_columns      
        y = y';%y should be a column vector      
    end 
    soft = @(x,T) sign(x).*max(abs(x) - T,0);
    n = size(Phi,2);    
    x = zeros(n,1);%Initialize x=0  
    f = 0.5*(y-Phi*x)'*(y-Phi*x)+lambda*sum(abs(x));%added in v1.1
    loop = 0; 
    fprintf('\n');
    while 1    
        x_pre = x;
        x = soft(x + Phi'*(y-Phi*x),lambda);%update x        
        loop = loop + 1;  
        f_pre = f;%added in v1.1
        f = 0.5*(y-Phi*x)'*(y-Phi*x)+lambda*sum(abs(x));%added in v1.1
        if abs(f-f_pre)/f_pre<epsilon%modified in v1.1
            fprintf('abs(f-f_pre)/f_pre<%f\n',epsilon);
            fprintf('IST loop is %d\n',loop);
            break;
        end
        if loop >= loopmax
            fprintf('loop > %d\n',loopmax);
            break;
        end
        if norm(x-x_pre)<epsilon
            fprintf('norm(x-x_pre)<%f\n',epsilon);
            fprintf('IST loop is %d\n',loop);
            break;
        end
    end  
end   
