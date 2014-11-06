function [ugc_qpsk]=ugc_encoder_qpsk(bitsource)
% b= 000 -> G1=[1 0;0 1];   
% b= 001 -> G2=[j 0;0 -j];
% b= 010 -> G3=[0 1;-1 0];
% b= 011 -> G4=[0 j;j 0];
% b= 100 -> G5=[-1 0;0 -1];
% b= 101 -> G6=[-j 0;0 j];
% b= 110 -> G7=[0 -1;1 0];
% b= 111 -> G8=[0 -j; -j 0];

load('QPSK_G.mat');
len=length(bitsource)/3;
ugc_qpsk=zeros(2,2*len);

for k=1:len
    if(bitsource(3*k-2)==0 & bitsource(3*k-1)==0 & bitsource(3*k)==0)
        ugc_qpsk(:,2*k-1:2*k)=G1;
    elseif(bitsource(3*k-2)==0 & bitsource(3*k-1)==0 & bitsource(3*k)==1)
        ugc_qpsk(:,2*k-1:2*k)=G2;
    elseif(bitsource(3*k-2)==0 & bitsource(3*k-1)==1 & bitsource(3*k)==0)
        ugc_qpsk(:,2*k-1:2*k)=G3;
    elseif(bitsource(3*k-2)==0 & bitsource(3*k-1)==1 & bitsource(3*k)==1)
        ugc_qpsk(:,2*k-1:2*k)=G4;
    elseif(bitsource(3*k-2)==1 & bitsource(3*k-1)==0 & bitsource(3*k)==0)
        ugc_qpsk(:,2*k-1:2*k)=G5;
    elseif(bitsource(3*k-2)==1 & bitsource(3*k-1)==0 & bitsource(3*k)==1)
        ugc_qpsk(:,2*k-1:2*k)=G6;
    elseif(bitsource(3*k-2)==1 & bitsource(3*k-1)==1 & bitsource(3*k)==0)
        ugc_qpsk(:,2*k-1:2*k)=G7;
    else
        ugc_qpsk(:,2*k-1:2*k)=G8;
        
    end
end