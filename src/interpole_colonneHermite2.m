function inter = interpole_colonneHermite2(x,y,tg_gamma,colonne)

% cette fonction s'utilise pour les 5 premieres colonnes sur 7 à compléter
% les deux dernieres beneficient d'un traitement particulier

% on a 6 valeurs disponibles pour l'interpolation

%on met une valeur differente de 0 dans les y(i) pour pouvoir prendre le log
[n, m] = size(y);
for i = 1:n 
    if (y(i) <= 0) 
        y(i) = 0.01;
    end
end

%entre les 5 premiers points de la colonne, interpolation cubic
interTmp(1:13) = interpCUBIC(x(1:5),y(1:5),tg_gamma(1:13));

%entre les points 4 et 6 : exp decroissante ax^2 + bx + c -> loi lognormale

nmoins2 = n-2;
nmoins1 = n-1;

x1 = log(x(nmoins2));
x2 = log(x(nmoins1));
x3 = log(x(n));


y1 = log(y(nmoins2));
y2 = log(y(nmoins1));
y3 = log(y(n));


a = (1/(x3-x1)) * ( ((y2-y3)/(x2-x3)) - ((y1-y2)/(x1-x2)));
b = ( (y1-y2) / (x1-x2) ) - (a*(x1+x2) );
c = ( y1 - ( a * ( x1*x1 ) ) - ( b * x1)); 


for i = 13:29
    interTmp(i) = exp(a*log(tg_gamma(i))*log(tg_gamma(i)) + b*log(tg_gamma(i)) + c);
end

inter = interTmp';

