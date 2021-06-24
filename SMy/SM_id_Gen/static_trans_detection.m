function [ trans,ac,P_norm ] = static_trans_detection( P, seuil_pos,seuil_neg,chopped )
%STATIC_TRANS_DETECTION Summary of this function goes here
%   Detailed explanation goes here






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Définition des constantes du problème
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%global xc_estim N theta0


N = length(P);

%seuil = 58/100;      % Seuil de détection des pics de la l'arccos
% QUI DOIT ETRE EVENTUELLEMENT MODIFIE



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


P = filtfilt(ones(1,2)/2,1,P);         % Très léger filtrage de P avec un filtre non causal
% par la fonction filtfilt. On
% filtre dans un sens, on retourne
% le signal filté, on le refiltre
% et on le retourne à nouveau
P = P - (max(P)+min(P))/2;           % Correction pour avoir P entre -M et +M

M_estim = max(abs(P));               % Amplitude max
P = P/M_estim;                       % On a maintenant    -1 < P < 1
P_norm = P;

%ac = acos(P);                           % Calcul de arccos()

ac =0*P;
ac_diff = filter([1 -1],1,P);           % Recherche des dicontinuités de ac par calcul de sa dérivée
ac_diff(1:chopped) = ac_diff(1:chopped)*0;        % On met à zéro les premiers points qui sont parfois genants
ac_diff(N-chopped:N) = ac_diff(N-chopped:N)*0;      % On met à zéro les derniers points qui sont parfois genants

vector_div_by_2_On = 1
if vector_div_by_2_On == 1
    trans1 = (ac_diff(1:end/2,1)<(seuil_neg*min(ac_diff(1:end/2,1)))) - (ac_diff(1:end/2,1)>(seuil_pos*max(ac_diff(1:end/2,1))));    % Calcul d'un signal de transition
    trans2 = (ac_diff(1+end/2:end,1)<(seuil_neg*min(ac_diff(1+end/2:end,1)))) - (ac_diff(1+end/2:end,1)>(seuil_pos*max(ac_diff(1+end/2:end,1))));    % Calcul d'un signal de transition
    trans = [trans1; trans2];
else
    trans = (ac_diff<(seuil_neg*min(ac_diff))) - (ac_diff>(seuil_pos*max(ac_diff)));    % Calcul d'un signal de transition
end

trans = filter([1,-1],1,(trans)).*((trans<0)+(trans>0));                    % On ne garde que les instants de transitions montantes ou descendantes
%trans = filter([-1,+1],1,(trans)).*((trans<0)+(trans>0));
%
[trans_max trans_max_ind] = max(trans);

while   trans_max > 1
    trans(trans_max_ind,1) = 1;     %%  in order to tacke the 2 , -1 trans
    trans(trans_max_ind - 1,1) = 0;
    
    [trans_max trans_max_ind] = max(trans);
end

[trans_min trans_min_ind] = min(trans);

while   trans_min < -1
    trans(trans_min_ind,1) = -1;     %%  in order to tacke the 2 , -1 trans
    trans(trans_min_ind - 1,1) = 0;
    
    [trans_min trans_min_ind] = min(trans);
end


trans = -1*trans; % as now i use P instead of ac

% to counter the often seen -1 spike in delta(ac) resulting in a +ve trans
% that appears at the max of P

% P_2 = P;
% for i = 1:600
%
%     [max_val max_ind]= max(P_2);
%
%     if ((any(trans(max_ind-10:max_ind,1) > 0 )) && (any(trans(max_ind+1:max_ind+15,1) < 0 )))
%         trans(max_ind-10:max_ind,1) = 0*(trans(max_ind-10:max_ind,1));
%         flag_false_pos_fringe_at_P_max = 1
%     end
%
%     P_2(max_ind-150:max_ind+2) = 0;
%
%     P_max_matrix (i,1)= max_ind;
%     P_max_matrix (i,2)= max_val;
% end


[max_val max_ind]= max(P);

if max_ind > 5
    if any(trans(max_ind-5:max_ind,1) > 0 )
        trans(max_ind-5:max_ind,1) = 0*(trans(max_ind-5:max_ind,1));
        flag_false_pos_fringe_at_P_max = 1
    end
end


figure_ON = 1;
if figure_ON == 1
    if vector_div_by_2_On == 0
    %figure('name','double  ')
     fig =figure('name','double vvv  ')
    %set (fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
    subplot(3,1,1:1); plot([P,trans]),grid on
    legend ('Self Mixing Signal')
    subplot(3,1,2:3); plot([ac_diff,seuil_pos*max(ac_diff)*ones(N,1),seuil_neg*min(ac_diff)*ones(N,1)]), grid on
    %legend ('Derivative of ac','max','min')
    else
        A = seuil_pos*max(ac_diff(1:end/2,1))*ones(N/2,1);
        B = seuil_pos*max(ac_diff(1+end/2:end,1))*ones(N/2,1);
        C = [A;B];
        
        D = seuil_neg*min(ac_diff(1:end/2,1))*ones(N/2,1);
        E = seuil_neg*min(ac_diff(1+end/2:end,1))*ones(N/2,1);
        F = [D;E];
        
             fig =figure('name','double vvv  ')
    %set (fig, 'Units', 'normalized', 'Position', [0,0,1,1]);
    subplot(3,1,1:1); plot([P,trans]),grid on
    legend ('Self Mixing Signal')
    subplot(3,1,2:3); plot([ac_diff,C,F]), grid on
    end
end

