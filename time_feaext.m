function [me,ma,mi,st,fc,pk ,rmse ,fgfz ,sf ,cf ,If ,Clf ,Kv]=time_feaext(y_in)
% ʱ��������ȡ���������ֵ����Сֵ��ƽ��ֵ���Ͷ����ӡ��Ͷȡ����ֵ��
% y_in �����ź�
% ma,mi,me,Kr,ku,pk
yg=y_in;
for i=1:40:960
    k=1:40:960;
    j=i:1:i+40;
    me(i)= mean(yg(j));         %ƽ��ֵ
    ma(i) = max(yg(j));         %���ֵ
    mi(i)= min(yg(j));          %��Сֵ
    st(i)=std(yg(j));           %��׼��
    fc(i)=st(i).^2;             %����
    pk(i)= ma(i)-mi(i);         %��-��ֵ
    rmse(i)=rms(yg(i));         % ������ֵ
    mes(i)=mean(abs(yg(j)));    %����ƽ��ֵ
    fgfz(i)=(sum(sqrt(abs(yg(j))))./92).^2; %������ֵ
    ku(i) = kurtosis(yg(j));    %�Ͷ�
    
    
    sf(i)=rmse(i)./mes(i);      %����ָ��
    cf(i)=ma(i)./rmse(i);       %��ֵָ��
    If(i)=ma(i)./mes(i);        %����ָ��
    Clf(i)=ma(i)./ fgfz(i);     %ԣ��ָ��
    Kv(i)=ku(i)./(rmse(i).^4);  %�Ͷ�ָ��
%     Kr(i) = sum(yg(j).^4)/sqrt(sum(yg(j).^2)) ;%�Ͷ�����
end  
ma=ma(k);
mi=mi(k);
me=me(k);
st=st(k); 
fc=fc(k);
pk=pk(k);
rmse=rmse(k);
fgfz=fgfz(k);
sf=sf(k);
cf=cf(k);
If=If(k);
Clf=Clf(k);
Kv=Kv(k);
% %% ��1��
% mab=max(ma);
% mas=min(ma);
% mag=(ma-mas)./(mab-mas);
% ma1b=max(ma1);
% ma1s=min(ma1);
% ma1g=(ma1-ma1s)./(ma1b-ma1s);
% %%%%%%%%%%%%%%%%%
% Krb=max(Kr);
% Krs=min(Kr);
% Krg=(Kr-Krs)./(Krb-Krs);
% Kr1b=max(Kr1);
% Kr1s=min(Kr1);
% Kr1g=(Kr1-Kr1s)./(Kr1b-Kr1s);
% %%%%%%%%%%%%%%%%%
% meb=max(me);
% mes=min(me);
% meg=(me-mes)./(meb-mes);
% me1b=max(me1);
% me1s=min(me1);
% me1g=(me1-me1s)./(me1b-me1s);
% %%%%%%%%%%%%%%%%%
% kub=max(pk);
% kus=min(pk);
% pkg=(pk-kus)./(kub-kus);
% ku1b=max(pk1);
% ku1s=min(pk1);
% pk1g=(pk1-ku1s)./(ku1b-ku1s);