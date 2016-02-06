function res = interpCUBIC(x,y,angles)

h = diff(x);    % DIFF(X), for a vector X, is [X(2)-X(1)  X(3)-X(2) ... X(n)-X(n-1)].       0.5000    0.5000    1.0000    2.0000    8.0000
y = y.';
[m,n] = size(y); % m=1, n=5,6,7... tout depend a qoui c'est applique



   u = angles(:)';
   q = length(u);       % donc q devrait valoir 29
   if any(diff(u) < 0)  % si l'une des differences entre deux consecutifs est nul alors trier ds l'ordre croissant
      [u,p] = sort(u);
   else                 % sinon p = vecteur 1..29
      p = 1:q;
   end

   % Find indices of subintervals, x(k) <= u < x(k+1).

   if isempty(u)        % on ne devrait jamais etre dans ce cas, tg-gamma n'est jamais vide !
      k = u;        
   else
      [ignore,k] = histc(u,x);       % ignore : le nb de valeurs qu'on ne connait pas entre deux valeurs de x consecutives : 2     2     4     4    16     1
                                     % k :  1     1     2     2     3     3     3     3     4     4     4     4     5     5     5    5     5     5     5     5     5     5     5     5     5     5     5     5     6
      k(u>=x(n)) = n-1;
      
   end

 
   
   s = u - x(k);
   for r = 1:m

      % Compute slopes and other coefficients.
   
      y;
      h;
      del = diff(y(r,:))./h;   % difference de deux y consecutifs, le tout divise par h
      
      if isreal(del)
          k2 = find(sign(del(1:n-2)).*sign(del(2:n-1)) > 0);      % quelle utilite ????
      else
          k2 = 1:n-2; % on est jamais danc ce cas.
      end      
      
      d = zeros(size(y));           % une ligne de zeros
      hs = h(k2)+h(k2+1);
      w1 = (h(k2)+hs)./(3*hs);
      w2 = (hs+h(k2+1))./(3*hs);
      k2;
      del;
      del(k2+1);
      dmax = max(abs(del(k2)), abs(del(k2+1)));
      dmin = min(abs(del(k2)), abs(del(k2+1)));
      %d(k2+1) = dmin./conj(w1.*(del(k2)./dmax) + w2.*(del(k2+1)./dmax));
      d(k2+1) = dmin./(w1.*(del(k2)./dmax) + w2.*(del(k2+1)./dmax));  % on ne devrait avoir que des valeurs reelles, donc pas besoin de prendre le conjugue
      
      %  Slopes at end points.
      %  Set d(1) and d(n) via non-centered, shape-preserving three-point formulae.
      
      d(1) = ((2*h(1)+h(2))*del(1) - h(1)*del(2))/(h(1)+h(2));
      if isreal(d) & (sign(d(1)) ~= sign(del(1)))
          d(1) = 0;
      elseif (sign(del(1)) ~= sign(del(2))) & (abs(d(1)) > abs(3*del(1)))
          d(1) = 3*del(1);
      end
      d(n) = ((2*h(n-1)+h(n-2))*del(n-1) - h(n-1)*del(n-2))/(h(n-1)+h(n-2));
      if isreal(d) & (sign(d(n)) ~= sign(del(n-1)))
          d(n) = 0;
      elseif (sign(del(n-1)) ~= sign(del(n-2))) & (abs(d(n)) > abs(3*del(n-1)))
          d(n) = 3*del(n-1);
      end
   
   
      
      c = (3*del - 2*d(1:n-1) - d(2:n))./h;
      b = (d(1:n-1) - 2*del + d(2:n))./h.^2;
   
      % Evaluate interpolant.
      res(m*(p-1)+r) = y(r,k) + s.*(d(k) + s.*(c(k) + s.*b(k)));
   
   end