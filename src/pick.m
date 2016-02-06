function pick = pick(tab)
% cette fonction permet, a partir du tableau CIE 29x20 de recuperer les 27
% coefficients qui nous interessent.

pick(1)  = tab(1,  1);
pick(2)  = tab(3,  1);
pick(3)  = tab(5,  1);
pick(4)  = tab(9,  1);
pick(5)  = tab(13, 1);
pick(6)  = tab(2,  5);
pick(7)  = tab(5,  5);
pick(8)  = tab(9,  5);
pick(9)  = tab(13, 5);
pick(10) = tab(3,  8);
pick(11) = tab(5,  8);
pick(12) = tab(9,  8);
pick(13) = tab(13, 8);
pick(14) = tab(3, 12);
pick(15) = tab(5, 12);
pick(16) = tab(9, 12);
pick(17) = tab(13,12);
pick(18) = tab(3, 14);
pick(19) = tab(5, 14);
pick(20) = tab(9, 14);
pick(21) = tab(13,14);
pick(22) = tab(3, 17);
pick(23) = tab(5, 17);
pick(24) = tab(9, 17);
pick(25) = tab(3, 20);
pick(26) = tab(5, 20);
pick(27) = tab(9, 20);

% et la brebis galeuse permettant de faire les tests pour r(0,12) :
pick(28) = tab(29, 1);