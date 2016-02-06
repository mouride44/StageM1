function teste_interpolation(t)
% cette fonction part d'un tableau complet, extrait les valeurs mesurées par Coluroute,
% calcule le tableau interpollé
% et trace le solide initial et interpollé sur le même graphique

% elle prend en entree :
%           le tableau de reference, soit en 29x20, soit en 30x21

% taille de t :
[m, n] = size(t)

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

% pic28 : pour recuperer les 27 pics et en 28e position la valeur de r(0,12)
% pic contient les valeurs des pic de depart
pic28 = pick(tab);
pic = pic28(1:27);

etalonnage=zeros(2,27);
etalonnage(1,:)=1;
interp = coluroute_interpHermite_mars2011(pic,etalonnage,'interpol');

enveloppe1(t,1,'r')
enveloppe1(interp,2,'b')

