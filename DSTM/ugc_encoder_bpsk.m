function [ugc_bpsk]=ugc_encoder_bpsk(bits)
%
% b=0 ==> identity matrix
% b=1 ==> inverse
%
load('BPSK_G.mat');
len=length(bits);
ugc_bpsk=zeros(2,2*len);

for k=1:len
    if(bits(k)==1)
        ugc_bpsk(:,2*k-1:2*k)=BPSK_G1;
    else
        ugc_bpsk(:,2*k-1:2*k)=BPSK_G2;
    end
end