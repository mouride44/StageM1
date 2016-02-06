function traceEnv4(tabEnv, nom, index, couleur, coef);
% version modifiée par R-Tech pour supprimer les lignes parasites
% du programme originel (traceEnv1).

% astuce : pour avoir une taille fixe de plot
% 
figure
set (gca, 'Xlim', [-500 600]);
set (gca, 'Ylim', [0 1100]);

index = index*2;

% il faut faire la boucle si on ne veut pas le lien entre deux lignes consecutives

derniereligne = 20; 
% les points correspondant aux trop grands gamma embrouillent inutilement
% le bas du graphique

i=0;
while (i < 20*derniereligne)
    hold on
    plot(tabEnv(1+i:20+i,4), tabEnv(1+i:20+i,5), couleur);
    i = i+20;
end
hold on

% idem pour les lignes verticales

i=0;
while (i < 580)
    hold on
    plot([tabEnv(1+i:29+i,9);0], [tabEnv(1+i:29+i,10);0], couleur);
    % on ajoute au bas de chaque ligne verticale un point (0,0) pour que
    % les quartiers d'orange soient complets
    i = i+29;
end
set(gca, 'Box', 'on');

%Rtech
%[minmax, tic] = findminmaxticround(tabEnv(:,10)*1.05);
%set (gca, 'Ylim', minmax, 'YTick', minmax(1):tic:minmax(2));
%axis equal
%a = xlim;
% val du 24 fév06 : marche mais je préfère sans
% maxi=max(tabEnv(:,10)*1.05);
% set (gca, 'Ylim', [0 maxi]);
% axis equal
% a = xlim;   % prends les limites de l'axe x

%fin val
Q0 = num2str(coef(1),2);
S1 = num2str(coef(2),2);
S2 = num2str(coef(3),2);

% titre de la figure et texte mis en forme
%txt = strcat(nom(1:7),' : ');
txt = strcat(nom,' : ');
txt2 = strcat(txt,' Q0 = ', Q0, ', S1 = ', S1, ', S2 = ', S2);
txt2=strcat('Q0 = ', Q0, ', S1 = ', S1, ', S2 = ', S2);
title(txt2,'FontName','Arial','Fontsize',11);
title(nom,'FontName','Comic Sans MS','Fontsize',12);
% version habituelle
h2 = text(-200, 1100-index*30, txt2,'Color',couleur,'FontName','Comic Sans MS','Fontsize',11);
% autre positionnement du texte
%h2 = text(-400, 1400-index*20, txt2,'Color',couleur,'FontName','Comic Sans MS','Fontsize',12);

