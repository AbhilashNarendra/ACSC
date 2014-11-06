function sym_hat=ugc_decoder_bpsk(G)

data_len=length(G);
m=1;
for k=1:2:data_len
    G_matrix=G(:,2*k-1:2*k);
    if(trace(G_matrix)>0)
        sym_hat(m)=1;
    else
        sym_hat(m)=-1;
    end
    m=m+1;
end