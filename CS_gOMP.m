function [ theta ] = CS_gOMP( y,A,K,S )
%   CS_gOMP
%   Detailed explanation goes here
%   y = Phi * x
%   x = Psi * theta
%    y = Phi*Psi * theta
%   �� A = Phi*Psi, ��y=A*theta
%   ������֪y��A����theta
%   Reference: Jian Wang, Seokbeop Kwon, Byonghyo Shim.  Generalized 
%   orthogonal matching pursuit, IEEE Transactions on Signal Processing, 
%   vol. 60, no. 12, pp. 6202-6216, Dec. 2012. 
%   Available at: http://islab.snu.ac.kr/paper/tsp_gOMP.pdf
    if nargin < 4
        S = 1;%round(max(K/8, 1))
    end
    [y_rows,y_columns] = size(y);
    if y_rows<y_columns
        y = y';%y should be a column vector
    end
    [M,N] = size(A);%���о���AΪM*N����
    theta = zeros(N,1);%�����洢�ָ���theta(������)
    Pos_theta = [];%�������������д洢A��ѡ��������
    r_n = y;%��ʼ���в�(residual)Ϊy
    for ii=1:K%����K�Σ�KΪϡ���
        product = A'*r_n;%���о���A������в���ڻ�
        [val,pos]=sort(abs(product),'descend');%��������
        Sk = union(Pos_theta,pos(1:S));%ѡ������S��
        if length(Sk)==length(Pos_theta)
            if ii == 1
                theta_ls = 0;
            end
            break;
        end
        if length(Sk)>M
            if ii == 1
                theta_ls = 0;
            end
            break;
        end
        At = A(:,Sk);%��A���⼸����ɾ���At
        %y=At*theta��������theta����С���˽�(Least Square)
        theta_ls = (At'*At)^(-1)*At'*y;%��С���˽�
        %At*theta_ls��y��At)�пռ��ϵ�����ͶӰ
        r_n = y - At*theta_ls;%���²в�
        Pos_theta = Sk;
        if norm(r_n)<1e-7
            break;%quit the iteration
        end
    end
    theta(Pos_theta)=theta_ls;%�ָ�����theta
end