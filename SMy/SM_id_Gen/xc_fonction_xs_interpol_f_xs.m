 
function xc = xc_fonction_xs_interpol_f_xs(xs,C0,theta)

% DESCRIPTION :
%   Fonction permettant de générer le signal x à partir du signal xs = 2*pi*nu_s*tau_D
%   Le coefficient C est supposé constant et égal à C0. L'approximation de
%   la relation théorique xc(t) = f[xs(t)]  reliant xs(t) à xc(t) est donnée par
%   simple interpolation
%
% APPEL DE LA FONCTION
%   xc = xc_fonction_xs_C_constant_interpol_f_xs(xs,C0,theta)
%
% ARGUMENTS DE LA FONCTION :
%   - xs :  Vecteur contenant les échantillons du signal x_s(t)
%   - C0 :  Valeur de C[x_c(t)=xs0]
%   - theta : Valeur de l'angle theta qui appartient à [O, pi/2]
%
% AUTEUR :
%   Guy PLANTIER - ESEO - guy.plantier@eseo.fr
%
% DATE :
%   1 juillet 2004

nb_pts_interp = 100;


xc = zeros(size(xs));

xs_min = min(xs);
xs_max = max(xs);


% Calcul de k_min et k_max qui doivent être pairs et qui
% correspondent aux équations suivantes
% k_min*pi-theta plus grande valeur inférieure à xs_min
% k_max*pi-theta plus petite valeur supérieure à xs_min

k_min = floor((xs_min+theta)/pi/2)*2-2;
k_max = ceil((xs_max+theta)/pi/2)*2+2;

k = k_min;
k_fonction_xs = k_min*ones(size(xs));        % Contient la valeur
                                             % courante de k correspondant à xs

if (C0 <=1)
    y_interpol = linspace(-pi,pi,nb_pts_interp)';
    while(k <= k_max)
        k_fonction_xs = k_fonction_xs + 2*double( xs > ((k+1)*pi -theta));
        k = k + 2;
    end
else
    beta = acos(-1/C0);
    gamma = beta +C0*sin(beta);
    y_interpol = linspace(-beta,beta,nb_pts_interp)';
    while(k <= k_max)
        xs_k1 = k*pi - theta + gamma;
        xs_k2 = (k+2)*pi - theta  - gamma;
        k_fonction_xs = k_fonction_xs + 2*trigger_simple_local(xs,xs_k2,xs_k1);
        k = k+2;
    end
end
x_interpol = y_interpol + C0*sin(y_interpol);
x = xs-k_fonction_xs*pi+theta;

xc = interp1(x_interpol,y_interpol,x,'cubic') + k_fonction_xs*pi-theta;



% ============================================================
% Fonction trigger_simple_local() qui n'est visible que par 
% les fonctions présentes dans ce fichier
% ============================================================

function y = trigger_simple_local(x,x1,x2)

% Cette fonction permet de calculer le signal de sortie d'un trigger simple
% avec les seuils x1 et x2. Les valeurs de la sortie sont 0 ou 1

y = zeros(size(x));

if (x(1)>x2)
    y(1) = 1;
elseif (x(1)<x1)
    y(1) = 0;
else
    y(1) = 0;
end

for k = 2:length(x)
    if (x(k)>x2)
        y(k) = 1;
    elseif (x(k)<x1)
        y(k) = 0;
    else
        y(k) = y(k-1);
    end
end
 








%% my additions to see the working of code
% 
% 
% 
% function xc = xc_fonction_xs_interpol_f_xs(xs,C0,theta)
% 
% % DESCRIPTION :
% %   Fonction permettant de générer le signal x à partir du signal xs = 2*pi*nu_s*tau_D
% %   Le coefficient C est supposé constant et égal à C0. L'approximation de
% %   la relation théorique xc(t) = f[xs(t)]  reliant xs(t) à xc(t) est donnée par
% %   simple interpolation
% %
% % APPEL DE LA FONCTION
% %   xc = xc_fonction_xs_C_constant_interpol_f_xs(xs,C0,theta)
% %
% % ARGUMENTS DE LA FONCTION :
% %   - xs :  Vecteur contenant les échantillons du signal x_s(t)
% %   - C0 :  Valeur de C[x_c(t)=xs0]
% %   - theta : Valeur de l'angle theta qui appartient à [O, pi/2]
% %
% % AUTEUR :
% %   Guy PLANTIER - ESEO - guy.plantier@eseo.fr
% %
% % DATE :
% %   1 juillet 2004
% 
% nb_pts_interp = 100;
% 
% 
% xc = zeros(size(xs));
% 
% xs_min = min(xs);
% xs_max = max(xs);
% 
% 
% % Calcul de k_min et k_max qui doivent être pairs et qui
% % correspondent aux équations suivantes
% % k_min*pi-theta plus grande valeur inférieure à xs_min
% % k_max*pi-theta plus petite valeur supérieure à xs_min
% 
% k_min = floor((xs_min+theta)/pi/2)*2-2;
% k_max = ceil((xs_max+theta)/pi/2)*2+2;
% 
% k = k_min;
% k_fonction_xs = k_min*ones(size(xs));        % Contient la valeur
%                                              % courante de k correspondant à xs
% 
% if (C0 <=1)
%     y_interpol = linspace(-pi,pi,nb_pts_interp)';
%     while(k <= k_max)
%         k_fonction_xs = k_fonction_xs + 2*double( xs > ((k+1)*pi -theta));
%         k = k + 2;
%     end
% else
%     beta = acos(-1/C0)
%     gamma = beta +C0*sin(beta)
%     y_interpol = linspace(-beta,beta,nb_pts_interp)';
%     while(k <= k_max)
%         xs_k1 = k*pi - theta + gamma;
%         xs_k2 = (k+2)*pi - theta  - gamma;
%         triggered = 2*trigger_simple_local(xs,xs_k2,xs_k1);
%         k_fonction_xs = k_fonction_xs + triggered;
%         k = k+2;
% 
%     end
% end
% 
% 
% %         figure('name','triggered AND  k_fonction_xs')
% % %         plot([triggered,k_fonction_xs]),grid on         %,x1_array,x2_array
% % %         xlabel ('p  ')
% % %         legend('triggered','k fonction xs')
% % %         ylabel('Amplitude')
% % subplot(2,1,1); plot([triggered]),grid on
% % legend ('triggered')
% % subplot(2,1,2); plot(k_fonction_xs),grid on
% % legend ('k fonction xs')
% % % subplot(3,1,3); plot(cubic_interpl),grid on
% % % legend ('cubic interpl')
%        
%         
% 
% x_interpol = y_interpol + C0*sin(y_interpol);
% 
% %         figure('name','X and Y interpol')
% %         plot([x_interpol,y_interpol]),grid on
% %         legend('x interpol','y interpol')
%         
%         
% x = xs - k_fonction_xs*pi + theta;
% 
% 
% %         figure('name','x  = xs - k_fonction_xs*pi +  theta')
% %         plot([x',xs']),grid on
% %         legend('x ','xs')
% 
% 
% cubic_interpl = interp1(x_interpol,y_interpol,x,'cubic');
%         
% %         figure('name','cubic interpl')
% %         plot([cubic_interpl]),grid on        
% 
% xc = cubic_interpl + k_fonction_xs*pi-theta;
% 
%         figure('name','XC = cubic interpl + k_fonction_xs*pi - theta     , xs')
%         plot([xc',xs']),grid on 
%         legend('xc ','xs')
%         
%         
%  figure('name',' interpol')       
% subplot(4,1,1);         plot([x_interpol,y_interpol]),grid on
%         legend('x interpol   [ \gamma~C to - \gamma~C  ]','y interpol [ \beta~\pi/2 to - \beta~\pi/2 ]')
%         xlabel ('( Interpolation Sample length )')
% ylabel ('radians')    %    ( \Beta to -\Beta )
% subplot(4,1,2);         plot([x']),grid on
%         legend('x ') %,'xs')
% subplot(4,1,3); plot(cubic_interpl),grid on
% legend ('cubic interpl')
% subplot(4,1,4); plot(xc),grid on
% legend ('xc')
% xlabel ('No. of OOP samples')
% ylabel ('(a.u)')
%         
%         
%         
%         
% 
% figure('name','XC = cubic interpl + k_fonction_xs*pi - theta     , xs')
% subplot(3,1,1); plot([xc',xs']),grid on
% % title ('(a)     Displacement  ')
% legend ('xc','xs')
% %xlabel ('OOP samples')
% ylabel ('( radians )')
% subplot(3,1,2); plot(xc),grid on
% %title ('(b)      LDOOP  ')
% legend ('xc')
% %xlabel ('OOP samples')
% %ylabel ('/pi')
% %ylabel('(\lambda/2)')
% subplot(3,1,3); plot(cubic_interpl),grid on
% %title ('(c)      Transitions  ')
% legend ('cubic interpl')
% xlabel ('No. of OOP samples')
% ylabel ('(a.u)')
% 
%  
% 
% figure('name','XC = cubic interpl + k_fonction_xs*pi - theta     , xs')
% subplot(5,1,1); plot([xc-mean(xc)]),grid on
% % title ('(a)     Displacement  ')
% legend ('xc  meaned')
% %xlabel ('OOP samples')
% ylabel ('( radians )')
% subplot(5,1,2); plot(xs-mean(xs)),grid on
% %title ('(b)      LDOOP  ')
% legend ('xs  meaned')
% %xlabel ('OOP samples')
% %ylabel ('/pi')
% %ylabel('(\lambda/2)')
% subplot(5,1,3); plot(cubic_interpl-mean(cubic_interpl)),grid on
% %title ('(c)      Transitions  ')
% legend ('cubic interpl meaned')
% xlabel ('No. of OOP samples')
% ylabel ('(a.u)')
% subplot(5,1,4); plot([triggered]),grid on
% legend ('triggered')
% subplot(5,1,5); plot(k_fonction_xs),grid on
% legend ('k fonction xs')        
% 
% % ============================================================
% % Fonction trigger_simple_local() qui n'est visible que par 
% % les fonctions présentes dans ce fichier
% % ============================================================
% 
% function y = trigger_simple_local(x,x1,x2)
% 
% % Cette fonction permet de calculer le signal de sortie d'un trigger simple
% % avec les seuils x1 et x2. Les valeurs de la sortie sont 0 ou 1
% 
% y = zeros(size(x));
% 
% if (x(1)>x2)
%     y(1) = 1;
% elseif (x(1)<x1)
%     y(1) = 0;
% else
%     y(1) = double( (rand(1)>0.5));
% end
% 
% for k = 2:length(x)
%     if (x(k)>x2)
%         y(k) = 1;
%     elseif (x(k)<x1)
%         y(k) = 0;
%     else
%         y(k) = y(k-1);
%     end
% end
% 
% 
% x1_array = x1*ones(size(x));
% x1_array = x1_array';
% x2_array = x2*ones(size(x));
% x2_array =x2_array';
% x = x';
% y = y';
% 
% x1-x2
% 
%             figure('name','jhfykj')
%             %clf
%             %hold on
%             plot([x,y,x1_array,x2_array]),grid on         %,x1_array,x2_array
%             xlabel ('p')
%             %legend ('Displacement  ')
%             %legend('x','y','x1','x2')
%             ylabel('Amplitude')
%             %hold on
% y = y';
% 
% 
% 
