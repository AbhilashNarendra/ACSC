function [ugc_8psk]=ugc_encoder_8psk(bitsource)
% b= 0000 -> G1=[1 0;0 1];   
% b= 0001 -> G2=[0.7071+0.7071*j 0;0 0.7071-0.7071*j];
% b= 0010 -> G3=[j 0;0 -j];
% b= 0011 -> G4=[-0.7071+0.7071*j 0;0 -0.7071-0.7071*j];
% b= 0100 -> G5=[-1 0;0 -1];
% b= 0101 -> G6=[-0.7071-0.7071*j 0;0 -0.7071+0.7071*j];
% b= 0110 -> G7=[-j 0;0 j];
% b= 0111 -> G8=[0.7071-0.7071*j 0;0 0.7071+0.7071*j];
% b= 1000 -> G9=[0 -1;1 0];   
% b= 1001 -> G10=[0 -0.7071-0.7071*j;0.7071-0.7071*j 0];
% b= 1010 -> G11=[0 -j;-j 0];
% b= 1011 -> G12=[0 0.7071-0.7071*j;-0.7071-0.7071*j 0];
% b= 1100 -> G13=[0 1;-1 0];
% b= 1101 -> G14=[0 0.7071+0.7071*j;-0.7071+0.7071*j 0];
% b= 1110 -> G15=[0 j;j 0];
% b= 1111 -> G16=[0 -0.7071+0.7071*j; 0.7071+0.7071*j 0];

load('8PSK_G.mat');
len=length(bitsource)/4;
ugc_8psk=zeros(2,2*len);

for k=1:len
    if(bitsource(4*k-3)==0 & bitsource(4*k-2)==0 & bitsource(4*k-1)==0 & bitsource(4*k)==0)
        ugc_8psk(:,2*k-1:2*k)=G1;
    elseif(bitsource(4*k-3)==0 & bitsource(4*k-2)==0 & bitsource(4*k-1)==0 & bitsource(4*k)==1)
        ugc_8psk(:,2*k-1:2*k)=G2;
    elseif(bitsource(4*k-3)==0 & bitsource(4*k-2)==0 & bitsource(4*k-1)==1 & bitsource(4*k)==0)
        ugc_8psk(:,2*k-1:2*k)=G3;
    elseif(bitsource(4*k-3)==0 & bitsource(4*k-2)==0 & bitsource(4*k-1)==1 & bitsource(4*k)==1)
        ugc_8psk(:,2*k-1:2*k)=G4;
    elseif(bitsource(4*k-3)==0 & bitsource(4*k-2)==1 & bitsource(4*k-1)==0 & bitsource(4*k)==0)
        ugc_8psk(:,2*k-1:2*k)=G5;
    elseif(bitsource(4*k-3)==0 & bitsource(4*k-2)==1 & bitsource(4*k-1)==0 & bitsource(4*k)==1)
        ugc_8psk(:,2*k-1:2*k)=G6;
    elseif(bitsource(4*k-3)==0 & bitsource(4*k-2)==1 & bitsource(4*k-1)==1 & bitsource(4*k)==0)
        ugc_8psk(:,2*k-1:2*k)=G7;
    elseif(bitsource(4*k-3)==0 & bitsource(4*k-2)==1 & bitsource(4*k-1)==1 & bitsource(4*k)==1)
        ugc_8psk(:,2*k-1:2*k)=G8;
    elseif(bitsource(4*k-3)==1 & bitsource(4*k-2)==0 & bitsource(4*k-1)==0 & bitsource(4*k)==0)
        ugc_8psk(:,2*k-1:2*k)=G9;
    elseif(bitsource(4*k-3)==1 & bitsource(4*k-2)==0 & bitsource(4*k-1)==0 & bitsource(4*k)==1)
        ugc_8psk(:,2*k-1:2*k)=G10;
    elseif(bitsource(4*k-3)==1 & bitsource(4*k-2)==0 & bitsource(4*k-1)==1 & bitsource(4*k)==0)
        ugc_8psk(:,2*k-1:2*k)=G11;
    elseif(bitsource(4*k-3)==1 & bitsource(4*k-2)==0 & bitsource(4*k-1)==1 & bitsource(4*k)==1)
        ugc_8psk(:,2*k-1:2*k)=G12;
    elseif(bitsource(4*k-3)==1 & bitsource(4*k-2)==1 & bitsource(4*k-1)==0 & bitsource(4*k)==0)
        ugc_8psk(:,2*k-1:2*k)=G13;
    elseif(bitsource(4*k-3)==1 & bitsource(4*k-2)==1 & bitsource(4*k-1)==0 & bitsource(4*k)==1)
        ugc_8psk(:,2*k-1:2*k)=G14;
    elseif(bitsource(4*k-3)==1 & bitsource(4*k-2)==1 & bitsource(4*k-1)==1 & bitsource(4*k)==0)
        ugc_8psk(:,2*k-1:2*k)=G15;
    else
        ugc_8psk(:,2*k-1:2*k)=G16;
 
        
    end
end