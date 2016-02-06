function Hermite040826 = coluroute_interpHermite_oct07(pic_init,etalonnage,fis,nomfich)

% interpolation pour Coluroute avec LED => plus d'inversion source 5 et 1

% sauvegarde du fichier si enregistre activé
%
% sauvegarde des coefficients photométriques possible dans Synthese_coeff
% pour cela définir le chemin et ouvrir "fis"
% et à la fin des traitements fermer (fis)

% chemin='E:\tabsCIEmatlab\';
% chemin_synt=strcat(chemin,'Synthese_coeff.xls');
% fis = fopen(chemin_synt,'w');
% fprintf(fis,'NOM_FICHIER \tQ0\tS1\tS2');
% tabRev2gomme = coluroute_interpHermite_oct07(Rev2gomme,etal1109,fis,'tabRev2gomme')
% % faire les traitements en série
%% fclose (fis)

pic=etalonnage(1,:).*pic_init+etalonnage(2,:);
a_moy=mean(etalonnage(1,:));


for i=1:length(pic)
    if pic(i)<0 pic(i)=0
    end
end


tab_cie=zeros(29,20); %rempli le tableau tab_cie avec des zeros
% affectation des sources dans le tableau CIE
tab_cie(1,:)=pic(1); %met la valeur pour tan gamma = 0, beta = 0 dans la premiere ligne
tab_cie(3,1)=pic(2);
tab_cie(5,1)=pic(3);
tab_cie(9,1)=pic(4);
tab_cie(13,1)=pic(5);
tab_cie(2,5)=pic(6);
tab_cie(5,5)=pic(7);
tab_cie(9,5)=pic(8);
tab_cie(13,5)=pic(9);
tab_cie(3,8)=pic(10);
tab_cie(5,8)=pic(11);
tab_cie(9,8)=pic(12);
tab_cie(13,8)=pic(13);
tab_cie(3,12)=pic(14);
tab_cie(5,12)=pic(15);
tab_cie(9,12)=pic(16);
tab_cie(13,12)=pic(17);
tab_cie(3,14)=pic(18);
tab_cie(5,14)=pic(19);
tab_cie(9,14)=pic(20);
tab_cie(13,14)=pic(21);
tab_cie(3,17)=pic(22);
tab_cie(5,17)=pic(23);
tab_cie(9,17)=pic(24);
tab_cie(3,20)=pic(25);
tab_cie(5,20)=pic(26);
tab_cie(9,20)=pic(27);

tg_gamma=[0:0.25:2 2.5:0.5:12]'; %en colonne, tan gamma varie de 0 a 2 par pas de .25 puis de 2.5 a 12 par pas de .5
col_remplie=[1 5 8 12 14 17 20]; %numeros des colonnes ou des valeurs ont deja ete affectees
lig_remplie=[1 2 3 5 9 13]; %numeros des lignes ou des valeurs ont deja ete affectees
tab=zeros(29,20); %rempli le tableau tab avec des zeros
tab(1,:)=tab_cie(1,:); %copie la premiere ligne de tab_cie dans tab 

% inteprolation colonne 1
colonne=1;

x=[0 0.5 1 2 4 12]; %lignes ou il y a des valeurs 
y=tab_cie([1 3 5 9 13 29],col_remplie(colonne)); 


%affectation d'une valeur pour tan gamma = 12 en fonction du coefficient s1
s1=tab_cie(9,1)/tab_cie(1,1);
if (s1<0.42)
    disp('type R1')

    % cf rapportPicR1
    % pic1 en fct r(0,12)   : 20.029x + 206.39
    a = 20.029;
    b = 206.39;
    y(6) = (y(1) - b) / a;
    
elseif (0.42<=s1 & s1<0.85)
    disp('type R2')
    % cf rapportPicR2 
    % pic5 en fct r(0,12 ) : y = 5.3476x + 12.11
    a = 5.347;
    b = 12.11;
    y(6) = (y(5) - b) / a; 
    
elseif (0.85<=s1 & s1<1.35)
    disp('type R3')
    
    % y = 5.8061x + 18.746 cf rapportPicR3 pic5 en fct r(0,12)
    a = 5.8061;
    b = 18.746;
    y(6) = (y(5) - b) / a;
    
else
    disp('type R4')
    
    % y = 2.697x + 272.37  cf rapportPicR4 pic5 en fct r(0,12)
    a = 2.697;
    b = 272.37;
    y(6) = (y(5) - b) / a;
    
end




tab(:,col_remplie(colonne))=interpole_colonneHermite2(x,y,tg_gamma,colonne);

% on regarde ou se trouve le minimum
ligneMin = 13;
minimum = tab(13,1);
for i = 14:29
    if (minimum > tab(i, 1))
        minimum = tab(i,1);
        ligneMin = i;
    end
end


% on regarde si le minimum est en r(0, 12)
if (minimum ~= tab(29, 1))
    n = 5;
    for i = n-2:n
        if (y(i) <= 0) 
            y(i) = 0.01;
        end
    end

    x1 = log(x(n-2));
    x2 = log(x(n-1));
    x3 = log(x(n));
    
    
    y1 = log(y(n-2));
    y2 = log(y(n-1));
    y3 = log(y(n));
    
    
    a = (1/(x3-x1)) * ( ((y2-y3)/(x2-x3)) - ((y1-y2)/(x1-x2)));
    b = ( (y1-y2) / (x1-x2) ) - (a*(x1+x2) );
    c = ( y1 - ( a * ( x1*x1 ) ) - ( b * x1)); 
    
    
    for i = 5:29
        interTmp(i) = exp(a*log(tg_gamma(i))*log(tg_gamma(i)) + b*log(tg_gamma(i)) + c);
    end
    
    % si le minimum n'est pas en r(0,12) alors extrapolation sur les 3 derniers points mesures affecter aux lignes 13 a 29
    tab(13:29, colonne) = interTmp(13:29)';

end
clear x y




% interpolation colonne 2
colonne=2;

x=[0 0.25 1 2 4 12];
y=tab_cie([1 2 5 9 13 29],col_remplie(colonne));


% affectation d'une valeur pour pic(6)
y(2) = tab(2,1);
   

tab(:,col_remplie(colonne))=interpole_colonneHermite2(x,y,tg_gamma,colonne);
clear x y





% interpolation colonnes 3, 4 et 5
colonne=3;

for colonne=3:5,
    x=[0 0.5 1 2 4 12];
    y=tab_cie([1 3 5 9 13 29],col_remplie(colonne));
    
    tab(:,col_remplie(colonne))=interpole_colonneHermite2(x,y,tg_gamma,colonne);  
    
    clear x y
end

% interpolation colonnes 6 et 7
colonne=6;

for colonne=6:7,
    x=[0 0.5 1 2 5.5 12];
    y=tab_cie([1 3 5 9 16 29],col_remplie(colonne));
    y(5)=0.01;
    
    %entre les 3 premiers points : interp cubic
    inter3(1:5)=interpCUBIC(x(1:3),y(1:3),tg_gamma(1:5));
    
    %apres le pt 3  : exp decroissante ax^2 + bx + c calculee sur les pts 2, 3 et 4 (PAS pr tan gamma = 12)
    x1=log(x(2));
    x2=log(x(3));
    x3=log(x(4));
    
    y1=log(y(2));
    y2=log(y(3));
    y3=log(y(4));
    
    a = (1/(x3-x1)) * ( ((y2-y3)/(x2-x3)) - ((y1-y2)/(x1-x2)));
    b = ( (y1-y2) / (x1-x2) ) - (a*(x1+x2) );
    c = ( y1 - ( a * ( x1*x1 ) ) - ( b * x1) ) ;
    
    for i = 5:29
        inter3(i)=exp(a*log(tg_gamma(i))*log(tg_gamma(i))+b*log(tg_gamma(i)) + c);
    end
        
    tab(:,col_remplie(colonne))=inter3(1:29)';
    
   
    clear x y inter3
end

% interpolation des lignes
beta=[0 2 5:5:45 60:15:180];
beta_remplie=[0 15 30 60 90 135 180];

tab2=zeros(29,20);
tab2(1,:)=tab(1,:);
inter040617lig(1,:)=tab(1,:);

for ligne=2:29 
    beta_remplie=[0 15 30 60 90 135 180];
    col_remplie=[1 5 8 12 14 17 20];
    y=tab(ligne,col_remplie);

    % il y a +0.001 pour ne pas avoir 0
    if ligne >= 2 & ligne <=9
        inter040617lig(ligne,:)=interpCUBIC(beta_remplie,y',beta');
    else
       
        % pour la ligne du moment, calcul des coefficients a et b
        j = 1;
        for i = 1:6
            a = (log(y(i+1)+0.001) - log(y(i)+0.001)) / (beta_remplie(i+1) - beta_remplie(i));
            b = log(y(i)+0.001) - a*beta_remplie(i);
            while (j<=20 & beta(j) <= beta_remplie(i+1))  
                inter040617lig(ligne,j) = exp(a*beta(j) + b);
                j = j+1;
            end
        end
    end
end

% mettre des zeros là ou il en faut physiquement :
 inter040617lig(16:29, 11:20) = zeros(14, 10);
 inter040617lig(17:29, 10)    = zeros(13, 1);
 inter040617lig(18:29, 9)     = zeros(12, 1);
 inter040617lig(20:29, 8)     = zeros(10, 1);
 inter040617lig(23:29, 7)     = zeros( 7, 1);
 inter040617lig(28:29, 6)     = zeros( 2, 1);

tab_cie=inter040617lig;
coef=coef_photometriques(tab_cie);
tableau_complet_cie=zeros(30,21);
tableau_complet_cie(1,2:21)=beta;
tableau_complet_cie(2:30,1)=tg_gamma;
tableau_complet_cie(2:30,2:21)=inter040617lig;

Hermite040826 = inter040617lig;

% calcul des coef pour pic
disp('coef coluroute Q0, s1, s2 : ');
coefpic = coef_photometriques(inter040617lig)

% calcul des pourcentages d'erreur
%erreurQ0 = (coefgonio(1) - coefpic(1))/coefgonio(1)*100;
%erreurs1 = (coefgonio(2) - coefpic(2))/coefgonio(2)*100;
%erreurs2 = (coefgonio(3) - coefpic(3))/coefgonio(3)*100;
%disp('erreur sur Q0, s1, s2');
%erreur = [erreurQ0, erreurs1, erreurs2]


%figure
%enveloppe1(gonio, 2, 'g')
%enveloppe1(Hermite040826, 1, 'b')
%enveloppe1(tab, 1, 'b')

nomfic=nomfich;
chemin='D:\tabsCIEmatlab\';
%enregistre(coef,tableau_complet_cie,chemin,nomfic); % a n'utiliser que sur le transportable !!!
 % enregistre_ordiVal(coef,tableau_complet_cie); % a n'utiliser que sur le transportable !!!
 
 fprintf(fis,'\n%s\t%2.4f\t%2.3f\t%2.3f',nomfic,coef(1),coef(2),coef(3));
   
   