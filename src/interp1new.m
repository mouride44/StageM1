function int=interp1new(x ,y,tg_gamma)
[n, m] = size(y);
[h,g]=size(x);
for i = 1:n
    if (y(i) <= 0)
        y(i) = 0.01;
    end
end
intr(1:7) = interp1(x(1:g-1),y(1:n-1),tg_gamma(1:7),'linear');


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


for i = 7:29
    if i>= 7 & i<=13
        n1=n-3;
        n2=n-2;
        x11 = log(x(n1));
        x22 = log(x(n2));
        x33 = log(x(n-1));
        
        
        y11 = log(y(n1));
        y22 = log(y(n2));
        y33 = log(y(n-1));
        a1 = (1/(x33-x11)) * ( ((y22-y33)/(x22-x33)) - ((y11-y22)/(x11-x22)));
        b1 = ( (y11-y22) / (x11-x22) ) - (a1*(x11+x22) );
        c1 = ( y11 - ( a1 * ( x11*x11 ) ) - ( b1 * x11))
        
        intr(i) = exp(a1*log(tg_gamma(i))*log(tg_gamma(i)) + b1*log(tg_gamma(i)) + c1) 
    else
           intr(i) = exp(a*log(tg_gamma(i))*log(tg_gamma(i)) + b*log(tg_gamma(i)) + c) 
    end
    end
    
    
    int = intr';
