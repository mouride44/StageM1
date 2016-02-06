function enveloppe(t, tabgonio, etal)
% cette fonction permet de tracer deux enveloppes, les graphes de deux lignes et de deux colonnes le tout dans une meme fenetre
% elle prend en entree :
% 1er parametre : t : 
%           soit un .pic (vecteur 27 lignes x 1 colonne) et dans ce cas on fera l'interpolation. Les sources doivent etre dans l'ordre : 5 1 2 3 4 6 7 8...
%           soit un tableau CIE 29x20 (donc sans les valeurs de tan gamma et de beta) ou un tableau CIE 30x21 (avec les valeurs de tan gamma et de beta)
% 2e parametre : tabgonio :
%           le tableau gonio de reference, soit en 29x20, soit en 30x21
% 3e parametre : etal
%           l'etalonnage a mettre pour l'interpolation (coluroute_interpHermite040816) si on a un .pic
%           sinon ce n'est pas la peine de mettre un 3e parametre



% taille de t :
[m, n] = size(t)

% cas ou il faut interpoler
if (m == 1 & n == 27)
    % cas ou il y a un etalonnage
    if nargin == 3
        tab = coluroute_interpHermite040816(t, etal, tabgonio);
    else
        error('avec un .pic, il faut un etalonnage en 3e parametre')
    end
else
    % cas ou t est un tableau 30x21
    if (m == 30 & n == 21)
        tab = t(2:30, 2:21);
    else
        % cas ou t est un tableau 29x20
        if (m == 29 & n == 20)
            tab = t;
        else
            % on est dans aucun de ces cas -> pb !
            error('Le premier parametre doit etre soit un vecteur colonne de lgr 27, soit un tableau 30x21, soit un tableau 29x20')
        end
    end
end

% pic28 : pour recuperer les 27 pics et en 28e position la valeur de r(0,12)
% pic contient les valeurs des pic de depart
pic28 = pick(tab);
pic = pic28(1:27);

% fonction pour tracer les enveloppes indicatrice de reflexion et colonnes et lignes
tabEnv = deplace(tab);
tabgonioEnv = deplace(tabgonio);

% trace les enveloppes du tabgonio et du tab
traceEnv(tabEnv, tabgonioEnv);


tanEval = [0:0.25:2 2.5:0.5:12];
betaEval = [0 2 5:5:45 60:15:180];

% profitons en pour tracer les colonnes interessantes...
hold on
subplot(2,2,1);
% pour beta = 0
ptmesures = pic(1:5);
tanmesures = [0 0.5 1 2 4];
plot(tanEval,tabgonio(1:29,1),'m')
hold on
plot(tanEval,tab(1:29,1),'c')
hold on 
plot(tanmesures, ptmesures, '*c')

% pour beta = 60
ptmesures(1) = pic(1);
ptmesures(2:5) = pic(14:17)
tanmesures = [0 0.5 1 2 4];
hold on
plot(tanEval,tabgonio(1:29,12),'r')
hold on
plot(tanEval,tab(1:29,12),'b')
hold on 
plot(tanmesures, ptmesures, '*b')
title('colonne beta = 0 et colonne beta = 60')
legend('ref gonio b = 0','interpolation b = 0','pts mesure b = 0', 'ref gonio b = 60','interpolation b = 60','pts mesure b = 60')



% ...et les lignes tout aussi interessantes
hold on
subplot(2,2,2);
% pour tan gamma = 0.25
plot(betaEval,tabgonio(2, 1:20),'m')
hold on
plot(betaEval,tab(2,1:20),'c')
hold on
plot(15, pic(6), '*c')
% pour tan gamma = 0.5
ptmesures(1) = tab(3, 1);
ptmesures(2) = tab(3, 5);
ptmesures(3) = tab(3, 8);
ptmesures(4) = tab(3, 12);
ptmesures(5) = tab(3, 14);
ptmesures(6) = tab(3, 17);
ptmesures(7) = tab(3, 20);
betamesures = [0 15 30 60 90 135 180];
plot(betaEval,tabgonio(3, 1:20),'r')
hold on
plot(betaEval,tab(3,1:20),'b')
hold on
plot(betamesures, ptmesures, '*b')
title('ligne tan gamma = 0.25 et tan gamma = 0.5')
legend('ref gonio tg = 0.25','interpolation tg = 0.25', 'pt controle tg = 0.25', 'ref gonio tg = 0.5','interpolation tg = 0.5', 'pts controle tg = 0.5')

