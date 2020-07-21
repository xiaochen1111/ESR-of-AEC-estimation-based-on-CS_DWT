function [ theta ] = CS_SWOMP( y,A,S,alpha )
%   CS_SWOMP
%   Detailed explanation goes here
%   y = Phi * x
%   x = Psi * theta
%    y = Phi*Psi * theta
%   �� A = Phi*Psi, ��y=A*theta
%   S is the maximum number of SWOMP iterations to perform
%   alpha is the threshold parameter
%   ������֪y��A����theta
%   Reference:Thomas Blumensath��Mike E. Davies��Stagewise weak gradient
%   pursuits[J]��IEEE Transactions on Signal Processing��2009��57(11)��4333-4346��
    if nargin < 4
        alpha = 0.5; %alpha��Χ(0,1),Ĭ��ֵΪ0.5
    end
    if nargin < 3
        S = 10; %SĬ��ֵΪ10
    end
    [y_rows,y_columns] = size(y);
    if y_rows<y_columns
        y = y'; %y should be a column vector
    end
    [M,N] = size(A); %���о���AΪM*N����
    theta = zeros(N,1); %�����洢�ָ���theta(������)
    Pos_theta = []; %�������������д洢A��ѡ��������
    r_n = y; %��ʼ���в�(residual)Ϊy
    for ss=1:S %������S��
        product = A'*r_n; %���о���A������в���ڻ�
        sigma = max(abs(product));
        Js = find(abs(product)>=alpha*sigma); %ѡ��������ֵ����
        Is = union(Pos_theta,Js); %Pos_theta��Js����
        if length(Pos_theta) == length(Is)
            if ss==1
                theta_ls = 0; %��ֹ��1�ξ���������theta_ls�޶���
            end
            break; %���û���µ��б�ѡ��������ѭ��
        end
        %At������Ҫ������������Ϊ��С���˵Ļ���(�������޹�)
        if length(Is)<=M
            Pos_theta = Is; %��������ż���
            At = A(:,Pos_theta); %��A���⼸����ɾ���At
        else%At�����������������б�Ϊ������ص�,At'*At��������
            if ss==1
                theta_ls = 0; %��ֹ��1�ξ���������theta_ls�޶���
            end
            break; %����forѭ��
        end
        %y=At*theta��������theta����С���˽�(Least Square)
        theta_ls = (At'*At)^(-1)*At'*y; %��С���˽�
        %At*theta_ls��y��At�пռ��ϵ�����ͶӰ
        r_n = y - At*theta_ls; %���²в�
        if norm(r_n)<1e-6 %Repeat the steps until r=0
            break; %����forѭ��
        end
    end
    theta(Pos_theta)=theta_ls;%�ָ�����theta
end