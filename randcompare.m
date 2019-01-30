%rewrite listofalignmentvalues script using cross products instead of dot
%products
%taking arcsin of the whatiwant result gives the final plot in theta
%compare this sin to the previous instance and compare averages

clear randdbx randdby randdby randdbz randdvelx randdvely randdvelz randvalues randdx
randdatabx=rand(257,257,257);
randdataby=rand(257,257,257);
randdatabz=rand(257,257,257);
randvelx=rand(257,257,257);
randvely=rand(257,257,257);
randvelz=rand(257,257,257);
dx = 2;
for dx=2:4:126
    i=1;
    clear bshape vshape
    randpartmeancross=[];
    randwholemeancross=[];
    randpartmeanfinal=[];
    randwholemeanfinal=[];
    while i < 257-dx
        randdbx(i,:,:) = randdatabx(i,:,:)-randdatabx(i+dx,:,:);
        randdby(i,:,:) = randdataby(i,:,:)-randdataby(i+dx,:,:);
        randdbz(i,:,:) = randdatabz(i,:,:)-randdatabz(i+dx,:,:);
        randdvelx(i,:,:) = randvelx(i,:,:)-randvelx(i+dx,:,:);
        randdvely(i,:,:) = randvely(i,:,:)-randvely(i+dx,:,:);
        randdvelz(i,:,:) = randvelz(i,:,:)-randvelz(i+dx,:,:);
        i=i+1
        dx
    end
    %defining normalization terms
    randbshape=[reshape(dbx,1,1,[]) reshape(randdby,1,1,[]) reshape(randdbz,1,1,[])];
    randvshape=[reshape(randdvelx,1,1,[]) reshape(randdvely,1,1,[]) reshape(randdvelz,1,1,[])];
    randbnorm = (power(randdbx,2)+power(randdby,2)+power(randdbz,2)).^(1/2);
    randvelnorm = (randdvelx.^2+randdvely.^2+randdvelz.^2).^(1/2);
    
    %cross product with separate means
    randpartmeancross(end+1)=mean(mean(mean((cross(randbshape,randvshape).*cross(randbshape,randvshape))))).^(1/2)./mean(mean(mean((randbnorm.*randvelnorm))));
    randpartmeanfinal=[randpartmeanfinal randpartmeancross];
    
    %cross product, mean taken all at once
    randwholemeancross(end+1)=mean(mean(mean((cross(randbshape,randvshape).*cross(randbshape,randvshape)).^(1/2)./[reshape(randdbx,1,1,size(randbshape,3)) reshape(randdby,1,1,size(randbshape,3)) reshape(randdbz,1,1,size(randbshape,3))])));
    randwholemeanfinal=[randwholemeanfinal randwholemeancross];
end
  
loglog(2:4:126,asin(randwholemeancross),'bo-')
hold on
loglog(2:4:126,asin(randpartmeanvalues),'rx-')
title('Alignment of B and velocity')
xlabel('dx in units h')
ylabel('mean alignment')