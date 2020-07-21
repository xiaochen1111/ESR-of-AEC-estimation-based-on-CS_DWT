function [me,ma,mi,st,fc,pk ,rmse ,fgfz ,sf ,cf ,If ,Clf ,Kv]=time_feaext(y_in)
% 时域特征提取：包含最大值、最小值、平均值、峭度因子、峭度、峰峰值。
% y_in 输入信号
% ma,mi,me,Kr,ku,pk
yg=y_in;
for i=1:40:960
    k=1:40:960;
    j=i:1:i+40;
    me(i)= mean(yg(j));         %平均值
    ma(i) = max(yg(j));         %最大值
    mi(i)= min(yg(j));          %最小值
    st(i)=std(yg(j));           %标准差
    fc(i)=st(i).^2;             %方差
    pk(i)= ma(i)-mi(i);         %峰-峰值
    rmse(i)=rms(yg(i));         % 均方根值
    mes(i)=mean(abs(yg(j)));    %绝对平均值
    fgfz(i)=(sum(sqrt(abs(yg(j))))./92).^2; %方根幅值
    ku(i) = kurtosis(yg(j));    %峭度
    
    
    sf(i)=rmse(i)./mes(i);      %波形指标
    cf(i)=ma(i)./rmse(i);       %峰值指标
    If(i)=ma(i)./mes(i);        %脉冲指标
    Clf(i)=ma(i)./ fgfz(i);     %裕度指标
    Kv(i)=ku(i)./(rmse(i).^4);  %峭度指标
%     Kr(i) = sum(yg(j).^4)/sqrt(sum(yg(j).^2)) ;%峭度因子
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
% %% 归1化
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