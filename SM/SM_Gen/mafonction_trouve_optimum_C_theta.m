function F = maf(xc_estim,cet,thet)



xse = xc_estim + cet*sin(xc_estim + thet+theta0);


[n,d] = butter(1,0.05);

xse = filter(n,d,xse);                 % On effectue un petit filtrage passe bas de xs 
dxse = filter([1 -1],1,xse);           % Dérivée de xs estimé
dxse(1:5,1) = zeros(5,1);                % On met à zéro les premiers points qui sont parfois genants
%dxse(N-4:N,1) = zeros(5,1);              % On met à zéro les derniers points qui sont parfois genants
F = mean((dxse-mean(dxse)).^2);
end


%%% My additions in code to visually evaluate the code %%%

% 
% global xc_estim N theta0
% 
% 
% xse = xc_estim + x(1)*sin(xc_estim + x(2)+theta0);
% 
% 
% figure('name','xse')
% clf
% plot(xse),grid on
% xlabel ('xse ')
% ylabel('Amplitude')
% %
% 
% 
% [n,d] = butter(1,0.05);
% 
% xse = filter(n,d,xse);                 % On effectue un petit filtrage passe bas de xs 
% 
% figure('name','filtered xse')
% clf
% plot(xse),grid on
% xlabel ('filtered xse ')
% ylabel('Amplitude')
% 
% dxse = filter([1 -1],1,xse);           % Dérivée de xs estimé
% 
% figure('name','derivative of xse')
% clf
% plot(dxse),grid on
% xlabel ('derivative of xse ')
% ylabel('Amplitude')
% 
% dxse(1:5) = zeros(5,1);                % On met à zéro les premiers points qui sont parfois genants
% dxse(N-4:N) = zeros(5,1);              % On met à zéro les derniers points qui sont parfois genants
% 
% 
% figure('name',' truncated derivative of xse')
% clf
% plot(dxse),grid on
% xlabel ('truncated derivative of xse ')
% ylabel('Amplitude')
% 
% 
% F = mean((dxse-mean(dxse)).^2);