clear dbx dby dby dbz dvelx dvely dvelz  dx
dx = 2;
partmeandotfinal=[];
wholemeandotfinal=[];
for dx=2:4:126
    i=1;
    partmeandot=[];
    wholemeandot=[];
    while i < 257-dx
        dbx(i,:,:) = databx(i,:,:)-databx(i+dx,:,:);
        dby(i,:,:) = databy(i,:,:)-databy(i+dx,:,:);
        dbz(i,:,:) = databz(i,:,:)-databz(i+dx,:,:);
        dvelx(i,:,:) = velx(i,:,:)-velx(i+dx,:,:);
        dvely(i,:,:) = vely(i,:,:)-vely(i+dx,:,:);
        dvelz(i,:,:) = velz(i,:,:)-velz(i+dx,:,:);
        i=i+1
        dx
    end
    %defining normalization constants
    bnorm = (power(dbx,2)+power(dby,2)+power(dbz,2)).^(1/2);
    velnorm = (dvelx.^2+dvely.^2+dvelz.^2).^(1/2);
    
    %dot product with separate means
    partmeandot(end+1)=mean(mean(mean(abs((dbx.*dvelx+dby.*dvely+dbz.*dvelz)))))./mean(mean(mean((bnorm.*velnorm))));
    partmeandotfinal=[partmeandotfinal mean(partmeandot)];
    
    %dot product, mean taken all at once
    wholemeandot(end+1)=mean(mean(mean(abs((dbx.*dvelx+dby.*dvely+dbz.*dvelz))./(bnorm(1:size(dbx,1),:,:).*velnorm(1:size(dbx,1),:,:)))));
    wholemeandotfinal=[wholemeandotfinal wholemeandot];
end
   

loglog(2:4:126,partmeandotfinal)
title('Alignment of B and velocity')
xlabel('dx in units h')
ylabel('mean alignment')