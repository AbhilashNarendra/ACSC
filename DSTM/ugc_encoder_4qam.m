function [ugc_qpsk]=ugc_encoder_4qam(bitsource)
%  G1=[1 0;0 1];   
%  G2=[j 0;0 -j];
%  G3=[0 1;-1 0];
%  G4=[0 j;j 0];
% b= 100 -> G5=[-1 0;0 -1];
% b= 101 -> G6=[-j 0;0 j];
% b= 110 -> G7=[0 -1;1 0];
% b= 111 -> G8=[0 -j; -j 0];

%load('QPSK_G.mat');
len=length(bitsource)/2;
ugc_qpsk=zeros(2,2*len);

for k=1:len
    if( bitsource(2*k-1)==0 & bitsource(2*k)==0)
        ugc_qpsk(:,2*k-1:2*k)=[1 0;0 1];
    elseif( bitsource(2*k-1)==0 & bitsource(2*k)==1)
        ugc_qpsk(:,2*k-1:2*k)=[j 0;0 -j];
    elseif( bitsource(2*k-1)==1 & bitsource(2*k)==0)
        ugc_qpsk(:,2*k-1:2*k)=[0 1;-1 0];
    else
        ugc_qpsk(:,2*k-1:2*k)=[0 j;j 0];
        
    end
end