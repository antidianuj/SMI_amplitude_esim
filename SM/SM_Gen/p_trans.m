function y=p_trans(f,F,P)
y=zeros(P,1);
for n=1:P
    y(n)=sum((abs(real(F))).*(1+f.^2).^n);
end
end