function [K]=cs_pca(y,w,r)
for K=2:2:160
    
     sig=compressed(y,w,r,K);
     sig4=compressed(y4,w,r,K);
     [pcaout]=feaext(sig);
     [pcaout4]=feaext(sig4);
     D=evalution(pcaout,pcaout4);
     cspca=[cspca,D(2,:)];
end
K=find(cspca==max(cspca));
K=2*K+1;