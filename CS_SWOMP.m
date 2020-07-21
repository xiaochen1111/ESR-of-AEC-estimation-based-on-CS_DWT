function [ theta ] = CS_SWOMP( y,A,S,alpha )
%   CS_SWOMP
%   Detailed explanation goes here
%   y = Phi * x
%   x = Psi * theta
%    y = Phi*Psi * theta
%   令 A = Phi*Psi, 则y=A*theta
%   S is the maximum number of SWOMP iterations to perform
%   alpha is the threshold parameter
%   现在已知y和A，求theta
%   Reference:Thomas Blumensath，Mike E. Davies．Stagewise weak gradient
%   pursuits[J]．IEEE Transactions on Signal Processing，2009，57(11)：4333-4346．
    if nargin < 4
        alpha = 0.5; %alpha范围(0,1),默认值为0.5
    end
    if nargin < 3
        S = 10; %S默认值为10
    end
    [y_rows,y_columns] = size(y);
    if y_rows<y_columns
        y = y'; %y should be a column vector
    end
    [M,N] = size(A); %传感矩阵A为M*N矩阵
    theta = zeros(N,1); %用来存储恢复的theta(列向量)
    Pos_theta = []; %用来迭代过程中存储A被选择的列序号
    r_n = y; %初始化残差(residual)为y
    for ss=1:S %最多迭代S次
        product = A'*r_n; %传感矩阵A各列与残差的内积
        sigma = max(abs(product));
        Js = find(abs(product)>=alpha*sigma); %选出大于阈值的列
        Is = union(Pos_theta,Js); %Pos_theta与Js并集
        if length(Pos_theta) == length(Is)
            if ss==1
                theta_ls = 0; %防止第1次就跳出导致theta_ls无定义
            end
            break; %如果没有新的列被选中则跳出循环
        end
        %At的行数要大于列数，此为最小二乘的基础(列线性无关)
        if length(Is)<=M
            Pos_theta = Is; %更新列序号集合
            At = A(:,Pos_theta); %将A的这几列组成矩阵At
        else%At的列数大于行数，列必为线性相关的,At'*At将不可逆
            if ss==1
                theta_ls = 0; %防止第1次就跳出导致theta_ls无定义
            end
            break; %跳出for循环
        end
        %y=At*theta，以下求theta的最小二乘解(Least Square)
        theta_ls = (At'*At)^(-1)*At'*y; %最小二乘解
        %At*theta_ls是y在At列空间上的正交投影
        r_n = y - At*theta_ls; %更新残差
        if norm(r_n)<1e-6 %Repeat the steps until r=0
            break; %跳出for循环
        end
    end
    theta(Pos_theta)=theta_ls;%恢复出的theta
end