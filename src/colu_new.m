function hermite=colu_new(pic,etal,nomfichier)

picnew=etal(1,:).*pic+etal(2,:);
moy=mean(etal(1,:));
%pour ne pas avoir desd valeurs négatif
for i=1:length(pic)
    if picnew(i)<0 picnew(i)=0
    end
end
%on va definie le tableau de la cie
cie_tabl=zeros(29,20);

cie_tabl(1,:)=picnew(1);
cie_tabl(2,1)=picnew(2);
cie_tabl(3,1)=picnew(3);
cie_tabl(5,1)=picnew(4);
cie_tabl(9,1)=picnew(5);
cie_tabl(13,1)=picnew(6);
cie_tabl(5,5)=picnew(7);
cie_tabl(7,5)=picnew(8);
cie_tabl(13,5)=picnew(9);
cie_tabl(3,8)=picnew(10);
cie_tabl(5,8)=picnew(11);
cie_tabl(7,8)=picnew(12);
cie_tabl(13,8)=picnew(13);
cie_tabl(2,11)=picnew(14);
cie_tabl(5,11)=picnew(15);
cie_tabl(7,11)=picnew(16);
cie_tabl(13,11)=picnew(17);
cie_tabl(3, 14)=picnew(18);
cie_tabl(5, 14)=picnew(19);
cie_tabl(9, 14)=picnew(20);
cie_tabl(13,14)=picnew(21);
cie_tabl(3, 17)=picnew(22);
cie_tabl(5, 17)=picnew(23);
cie_tabl(9, 17)=picnew(24);
cie_tabl(3, 20)=picnew(25);
cie_tabl(5, 20)=picnew(26);
cie_tabl(9, 20)=picnew(27);

%les valeurs de tang gamma
tg_gamma=[0:0.25:2 2.5:0.5:12]'
%les numero de la colonne remplie
new_col_rempli=[1 5 8 11 14 17 20];
new_lig_rempli=[1 2 3 5 9 13];
%new tab
tab=zeros(29,20);
tab(1,:)=cie_tabl(1,:);

% inteprolation colonne 1
colonne=1;
x=[0  0.25 0.5 1 2 4 12];
y=cie_tabl([1 2 3 5 9 13 29],new_col_rempli(colonne));
%on va donner la valeur de  s1
s1=cie_tabl(9,1)/cie_tabl(1,1);
%affectation d'une valeur pour tan gamma = 12 en fonction du coefficient s1
if (s1<0.42)
    disp('type R1')
    % cf rapportPicR1
    % pic1 en fct r(0,12)   : 20.029x + 206.39
    a = 20.029;
    b = 206.39;
    y(7) = (y(1) - b) / a;
    % y(6)=36;
    
elseif (0.42<=s1 & s1<0.85)
    disp('type R2')
    % cf rapportPicR2
    % pic5 en fct r(0,12 ) : y = 5.3476x + 12.11
    
    a = 5.347;
    b = 12.11;
    y(7) = (y(6) - b) / a;
    
elseif (0.85<=s1 & s1<1.35)
    disp('type R3')
    % y = 5.8061x + 18.746 cf rapportPicR3 pic5 en fct r(0,12)
    a = 5.8061;
    b = 18.746;
    y(7) = (y(6) - b) / a;
    
else
    disp('type R4')
    % y = 2.697x + 272.37  cf rapportPicR4 pic5 en fct r(0,12)
    a = 2.697;
    b = 272.37;
    y(7) = (y(6) - b) / a;
    
end


tab(:,new_col_rempli(colonne))=interpole_colonneHermite2(x,y,tg_gamma,colonne);

%on regarde ou se trouve le minimum
minimum = tab(13,1);
for i = 14:29
    if (minimum > tab(i, 1))
        minimum = tab(i,1);
        ligneMin = i;
    end
end
%on regarde si le minimun est en r(0,12)
if(minimum ~=tab(29,1))
    n=6;
    for i=n-2:n
        if (y(i)<=0)
            y(i)=0;
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
    
    tab(13:29, colonne) = interTmp(13:29)';
    
end
clear x y
%interpolation colonne 2
colonne=2;
x=[0 0.25 1  1.5 4 12];
y=cie_tabl([1 2  5 7 13 29],new_col_rempli(colonne));
a=(cie_tabl(2,11)-cie_tabl(2,1))/45;

y(2)=(a*15)+cie_tabl(2,1);
%affectation d'une valeur a pic 6
tab(:,new_col_rempli(colonne))=interpole_colonneHermite2(x,y,tg_gamma,colonne);
%tab(:,new_col_rempli(colonne))=interp1new(x,y,tg_gamma);

%interpolation colonne 3
colonne=3;
x=[0  0.25 0.5 1 1.5 4 12];
y=cie_tabl([1 2 3 5 7 13  29],new_col_rempli(colonne));

%tab(:,new_col_rempli(colonne))=interp1new(x,y,tg_gamma);
a=(cie_tabl(2,11)-cie_tabl(2,1))/45;

y(2)=(a*30)+cie_tabl(2,1);

%tab(:,new_col_rempli(colonne))=interp1new(x,y,tg_gamma);
tab(:,new_col_rempli(colonne))=interpole_colonneHermite2(x,y,tg_gamma,colonne);
clear x y
%interpolation colonne 4
colonne=4;
x=[0 0.25 1 1.5 4 12];
y=cie_tabl([1 2 5 7 13 29],new_col_rempli(colonne));
tab(:,new_col_rempli(colonne))=interpole_colonneHermite2(x,y,tg_gamma,colonne);
%tab(:,new_col_rempli(colonne))=interp1new(x,y,tg_gamma);

clear x y
%interpolation colonne 5
colonne=5;
x=[0  0.5 1 2 4 12];
y=cie_tabl([1  3 5 9 13 29],new_col_rempli(colonne));

tab(:,new_col_rempli(colonne))=interpole_colonneHermite2(x,y,tg_gamma,colonne);
%tab(:,new_col_rempli(colonne))=interp1new(x,y,tg_gamma);
clear x y
%interpolation colonne 6 7

for colonne = 6:7
    x=[0  0.5 1 2 12];
    y=cie_tabl([1 3 5 9 29],new_col_rempli(colonne));
    
    %     entre les 3 premiers point de ces colonnes opn fait interpolationn
    %     cubic
    inter3(1:5)=interp1(x(1:3),y(1:3),tg_gamma(1:5),'PCHIP');
    %     apres le pt 3  : exp decroissante ax^2 + bx + c calculee sur les pts 2, 3 et 4 (PAS pr tan gamma = 12)
    
    x1=log(x(2));
    x2=log(x(3));
    x3=log(x(4));
    
    
    y1=log(y(2));
    y2=log(y(3));
    y3=log(y(4));
    
    a = (1/(x3-x1)) * ( ((y2-y3)/(x2-x3)) - ((y1-y2)/(x1-x2)));
    b = ( (y1-y2) / (x1-x2) ) - (a*(x1+x2) );
    c = ( y1 - ( a * ( x1*x1 ) ) - ( b * x1) ) ;
    for i=5:29
        inter3(i)=exp(a*log(tg_gamma(i))*log(tg_gamma(i))+b*log(tg_gamma(i)) + c);
    end
    tab(:,new_col_rempli(colonne))=inter3(1:29)';
    
    clear x y inter3
end

%INTERPOLATION DES LIGNES
beta=[0 2 5:5:45 60:15:180];
tabt=zeros(29,20);
tablt(1,:)=tab(1,:);
%interligne(1,:)=tab(1,:);
interligne=zeros(29,20);
for ligne=1:29
    new_beta_rempli=[0 15 30 45 90 135 180];
    new_col_rempli=[1 5 8 11 14 17 20];
    y=tab(ligne,new_col_rempli);
    
    
    
    %  on va utiliser l'interpolation cubic pour les ligne de 2 a 9
    if ligne >= 1 & ligne<=9
        
        interligne(ligne,:)=interpCUBIC(new_beta_rempli,y',beta');
        
        %     elseif ligne==4
        %
        %         interligne(ligne,:)=interpli(y',beta',new_beta_rempli)
        %
        %     elseif ligne >=5 & ligne <=9
        %         interligne(ligne,:)=interpCUBIC(new_beta_rempli,y',beta')
        
        
    else
        j = 1;
        for i = 1:6
            a = (log(y(i+1)+0.001) - log(y(i)+0.001)) / (new_beta_rempli(i+1) - new_beta_rempli(i));
            b = log(y(i)+0.001) - a*new_beta_rempli(i);
            while (j<=20 & beta(j) <= new_beta_rempli(i+1))
                interligne(ligne,j) = exp(a*beta(j) + b);
                j = j+1;
            end
        end
    end
end

%mettre des zeros la il faut physiquement
interligne(16:29,11:20)=zeros(14,10);
interligne(17:29, 10) = zeros(13, 1);
interligne(18:29, 9)  = zeros(12, 1);
interligne(20:29, 8)  = zeros(10, 1);
interligne(23:29, 7)  = zeros( 7, 1);
interligne(28:29, 6) = zeros( 2, 1);

cie_tabl=interligne;

tableau_complet_cie=zeros(30,21);
tableau_complet_cie(1,2:21)=beta;
tableau_complet_cie(2:30,1)=tg_gamma;
tableau_complet_cie(2:30,2:21)=interligne;
hermite=interligne;
disp('coef coluroute Q0, s1, s2 : ');
coefpic = coef_photometriques(interligne)

























