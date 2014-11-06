function tx=dif_encoder(D,ugc)


nr_ugc=size(ugc,2)/2;
tx=zeros(2,nr_ugc*2);
for k=1:nr_ugc
    if(k==1)
        tx(:,1:2)=D*ugc(:,1:2);
    else
        tx(:,2*k-1:2*k)=tx(:,2*k-3:2*k-2)*ugc(:,2*k-1:2*k);

    end
end