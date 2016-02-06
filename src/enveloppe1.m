function enveloppe1(tableau, index, couleur)
% fonction pour tracer une enveloppe indicatrice de reflexion
% le tableau doit etre de taille 30(lignes)x21(colonnes) ou 29x20

% traitement du parametre couleur
if (couleur ~= 'y' & couleur ~= 'm' & couleur ~= 'c' & couleur ~= 'r' & couleur ~= 'g' & couleur ~= 'b' & couleur ~= 'k')     
    error('Le 4e paramètre représente la couleur. Il doit valoir ''y'', ''m'', ''c'', ''r'', ''g'', ''b'', ou ''k''.')
end

% traitement du parametre index
if (index > 7 | index < 1)
    error('Le 3e parametre represente l''index. Il doit etre compris entre 1 et 7 inclus.')
end

% traitement de la taille du tableau
[m, n] = size(tableau);
if (m == 30 & n ~= 21) | (m ~= 30 & n == 21) | (m == 29 & n ~= 20) | (m ~= 29 & n == 20)%( m ~= 30 | n~=21 ) | ( m ~= 29 | n~=20 )
    error('Le tableau doit etre de taille 30x21 (avec les valeurs de tan gamma et de beta) ou 29x20 (sans les valeurs de tan gamma et de beta)')
end

if ( m == 30 | n == 21 )
    tab(1:29, 1:20) = tableau(2:30, 2:21);
else
    tab(:,:) = tableau(:,:);
end

% calcul des coefficients photometriques
coef = coef_photometriques(tab);

% deplacement du tableau tab
tabEnv = deplace(tab);

% trace les enveloppes du tabgonio et du tab
nom = inputname(1);
%traceEnv3(tabEnv, nom, index, couleur, coef);
traceEnv4(tabEnv, nom, index, couleur, coef);
%traceEnvSansNom(tabEnv, nom, index, couleur, coef);
% 1 en général
