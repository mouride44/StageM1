function cColu = clarte_Coluroute(pic_c,tab,cos_cube_gamma)

for i=1:10,
    pic=pic_c(i,:);
    
   % moyenne du c des 27 sources
    cColu(1,i)=mean(pic(1:27)) ;
    
    % moyenne du c sans source 4 et 5
    cColu(2,i)= (sum(pic(1:3))+ sum(pic(6:27))) /25;
   
    % moyenne sources en renforcement
    somme =0;
    somme=pic(1)+pic(2)+pic(3)+pic(6)+pic(7)+pic(10)+pic(11)+pic(14)+pic(15)+pic(18)+pic(19);
    cColu(3,i)=somme/11;
    
    % moyenne table en renforcement
    for beta=1:20,
         tab_c(:,beta,i)=pi()*tab(:,beta,i)./cos_cube_gamma(:)/10000;
    end
    cColu(4,i)=sum(sum(tab_c(1:14,1:6,i)))/84;  % car 84 valeurs
    
    % moyenne table en renforcement avec 1 fois la source 1
    cColu(5,i)=( tab_c(1:1)+sum(sum(tab_c(1:14,2:6,i))) )/65;  % car 65 valeurs
   
end
end
