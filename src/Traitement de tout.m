%SCRIPT TRAITEMENT AU KILOMETRE
% comparaison de l'ancien et du nouveau traitement



chemin='C:\Coluroute\dataMathlab\';
%chemin='C:\MUZET\Coluroute\data\';
chemin_synt=strcat(chemin,'Synthese_coeff.xls');
fis = fopen(chemin_synt,'w');
fprintf(fis,'NOM_FICHIER \tQ0\tS1\tS2');


% étalonnage simple

etalonnage=[1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0];


% traitement carottes type R1
nombre= length(R1);
S= struct('nom',{'R1_1' ; 'R1_2' ; 'R1_3' ; 'R1_4'});  % ; 'p80' ; 'pGris' });
for i=1:length(S),
	pic_initial=pick(R1{i});
    a = S(i,1);
    tab_initial=zeros(29,20);
	tab_initial=coluroute_interpHermite_classique(pic_initial(1:27),etalonnage,fis,chemin,a.nom);
end
fclose(fis)




% S = struct('nom',{'c8' ; 'C9' ; 'c11' ; 'c14' ; 'p80' ; 'pGris' });
% taille = length(S);
% EtalonsEtal=zeros(taille,29,20);
% for i=1:taille,
%      a = S(i,1);
%      EtalonsEtal(i,:,:)= coluroute_interpHermite_mars2011(PicEtalons(i,:),etal,fis,chemin,a.nom);
% end
% EtalonChantier=zeros(taille,29,20);
% for i=1:taille,
%      a = S(i,1);
%      EtalonChantier(i,:,:)= coluroute_interpHermite_mars2011(PicEtalons(i,:),etalChantier,fis,chemin,a.nom);
% end
% 
% fclose(fis)


% defini les noms et les sauve dans synthese et avec les bons noms
S = struct('nom',{'TemoinP1BrT6m' ; 'TemoinP2BrT6m' ; 'TemoinP3BrT6m' ; 'TemoinP4BrT6m' ; 'TemoinP1BcT6m' ; 'TemoinP2BcT6m' ; 'TemoinP3BcT6m' ; 'TemoinP4BcT6m' });
taille = length(S);
TemoinT6m=zeros(taille,29,20);
for i=1:taille,
     a = S(i,1);
     TemoinT6m(i,:,:)= coluroute_interpHermite_mars2011(PicTemoin(i,:),etal,fis,chemin,a.nom);
end
% TemoinEtalChantier=zeros(taille,29,20);
% for i=1:taille,
%      a = S(i,1);
%      TemoinEtalChantier(i,:,:)= coluroute_interpHermite_mars2011(PicTemoin(i,:),etalChantier,fis,chemin,a.nom);
% end

S = struct('nom',{'HydroP1BrT6m' ; 'HydroP2BrT6m' ; 'HydroP3BrT6m' ; 'HydroP4BrT6m' ; 'HydroP1BcT6m' ; 'HydroP2BcT6m' ; 'HydroP3BcT6m' ; 'HydroP4BcT6m'});
taille = length(S);
HydroT6m=zeros(taille,29,20);
for i=1:taille,
     a = S(i,1);
     HydroT6m(i,:,:)= coluroute_interpHermite_mars2011(PicHydro(i,:),etal,fis,chemin,a.nom);
end

S = struct('nom',{'Lumi1P1BrT6m' ; 'Lumi1P2BrT6m' ; 'Lumi1P3BrT6m' ; 'Lumi1P4BrT6m' ; 'Lumi1P1BcT6m' ; 'Lumi1P2BcT6m' ; 'Lumi1P3BcT6m' ; 'Lumi1P4BcT6m'});
taille = length(S);
Lumi1T6m=zeros(taille,29,20);
for i=1:taille,
     a = S(i,1);
     Lumi1T6m(i,:,:)= coluroute_interpHermite_mars2011(PicLumi1(i,:),etal,fis,chemin,a.nom);
end

S = struct('nom',{'Lumi2P1BrT6m' ; 'Lumi2P2BrT6m' ; 'Lumi2P3BrT6m' ; 'Lumi2P4BrT6m' ; 'Lumi2P1BcT6m' ; 'Lumi2P2BcT6m' ; 'Lumi2P3BcT6m' ; 'Lumi2P4BcT6m'});
taille = length(S);
Lumi2T6m=zeros(taille,29,20);
for i=1:taille,
     a = S(i,1);
     Lumi2T6m(i,:,:)= coluroute_interpHermite_mars2011(PicLumi2(i,:),etal,fis,chemin,a.nom);
end

fclose(fis)

% tracé des enveloppes représentatives
% echelle -200 900 en x, 600 en y
% maj à faire

figure; TemoinP1BrT6m(:,:)=TemoinT6m(1,:,:);   enveloppe1(TemoinP1BrT6m,1,'b');
figure; TemoinP2BrT6m(:,:)=TemoinT6m(2,:,:);   enveloppe1(TemoinP2BrT6m,1,'b');
figure; TemoinP1BcT6m(:,:)=TemoinT6m(5,:,:);   enveloppe1(TemoinP1BcT6m,1,'b');
figure; TemoinP2BcT6m(:,:)=TemoinT6m(6,:,:);   enveloppe1(TemoinP2BcT6m,1,'b');

figure; HydroP2BrT6m(:,:)=HydroT6m(2,:,:);   enveloppe1(HydroP2BrT6m,1,'b');
figure; HydroP3BrT6m(:,:)=HydroT6m(3,:,:);   enveloppe1(HydroP3BrT6m,1,'b');
figure; HydroP2BcT6m(:,:)=HydroT6m(6,:,:);   enveloppe1(HydroP2BcT6m,1,'b');
figure; HydroP3BcT6m(:,:)=HydroT6m(7,:,:);   enveloppe1(HydroP3BcT6m,1,'b');

figure; Lumi1P1BrT6m(:,:)=Lumi1T6m(1,:,:);   enveloppe1(Lumi1P1BrT6m,1,'b');
figure; Lumi1P3BrT6m(:,:)=Lumi1T6m(3,:,:);   enveloppe1(Lumi1P3BrT6m,1,'b');
figure; Lumi1P1BcT6m(:,:)=Lumi1T6m(5,:,:);   enveloppe1(Lumi1P1BcT6m,1,'b');
figure; Lumi1P3BcT6m(:,:)=Lumi1T6m(7,:,:);   enveloppe1(Lumi1P3BcT6m,1,'b');
%figure; Lumi1BandeNoire(:,:)=Lumi1(9,:,:);   enveloppe1(Lumi1BandeNoire,1,'b');

figure; Lumi2P1BrT6m(:,:)=Lumi2T6m(1,:,:);   enveloppe1(Lumi2P1BrT6m,1,'b');
figure; Lumi2P3BrT6m(:,:)=Lumi2T6m(3,:,:);   enveloppe1(Lumi2P3BrT6m,1,'b');
figure; Lumi2P1BcT6m(:,:)=Lumi2T6m(5,:,:);   enveloppe1(Lumi2P1BcT6m,1,'b');
figure; Lumi2P3BcT6m(:,:)=Lumi2T6m(7,:,:);   enveloppe1(Lumi2P3BcT6m,1,'b');

%TemoinP1BrEtalChantier(:,:)=TemoinEtalChantier(1,:,:);
%enveloppe1(TemoinP1BrEtalChantier,2,'c');
subplot 122; hold on
TemoinP1BcEtal(:,:)=TemoinEtal(5,:,:);
enveloppe1(TemoinP1BcEtal,1,'b');
%TemoinP1BcEtalChantier(:,:)=TemoinEtalChantier(5,:,:);
%enveloppe1(TemoinP1BcEtalChantier,2,'c');



