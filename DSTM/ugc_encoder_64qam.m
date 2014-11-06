function [ugc_64qam]=ugc_encoder_64qam(bitsource)
 G1=[1 0;0 1];   
 G2=[0.9808 + 0.1951i     0;0   -0.1951 + 0.9808i];
 G3=[0     0.9569 + 0.2903i;-0.2903 + 0.9569i        0];
 G4=[0.9239 + 0.3827i    0;0      -0.3827 + 0.9239i];
 G5=[0   0.8819 + 0.4714i;-0.4714 + 0.8819i        0 ];
G6=[0.8315 + 0.5556i        0;0    -0.5556 + 0.8315i];
 G7=[0     0.7730 + 0.6344i;-0.6344 + 0.7730i        0];
 G8=[0.7071+0.7071*j 0;0 -0.7071+0.7071*j];
 G9=[0      0.6344 + 0.7730i; -0.7730 + 0.6344i     0];   
G10=[0.5556 + 0.8315i        0;0      -0.8315 + 0.5556i];
G11=[0             0.4714 + 0.8819i;-0.8819 + 0.4714i        0];
G12=[0.3827 + 0.9239i        0;0            -0.9239 + 0.3827i];
G13=[0           0.2903 + 0.9569i;-0.9569 + 0.2903i        0];
G14=[0.1951 + 0.9808i        0 ;0         -0.9808 + 0.1951i];
G15=[ 0             0.0980 + 0.9952i;-0.9952 + 0.0980i        0];
G16=[0.0000 + 1.0000i        0 ;0          -1.0000 + 0.0000i];
G17=[0            -0.0980 + 0.9952i;-0.9952 - 0.0980i        0];
G18=[-0.1951 + 0.9808i        0;0            -0.9808 - 0.1951i];
G19=[ 0          -0.2903 + 0.9569i;-0.9569 - 0.2903i       0];
G20=[ -0.3827 + 0.9239i        0;0          -0.9239 - 0.3827i];
G21=[0            -0.4714 + 0.8819i;-0.8819 - 0.4714i        0];
G22=[-0.5556 + 0.8315i        0;0           -0.8315 - 0.5556i];
G23=[ 0            -0.6344 + 0.7730i;-0.7730 - 0.6344i        0 ];
G24=[-0.7071 + 0.7071i        0;0        -0.7071 - 0.7071i];
G25=[0     -0.7730 + 0.6344i; -0.6344 - 0.7730i        0];
G26=[-0.8315 + 0.5556i        0 ;0            -0.5556 - 0.8315i];
G27=[0            -0.8819 + 0.4714i;-0.4714 - 0.8819i        0];
G28=[-0.9239 + 0.3827i        0;0          -0.3827 - 0.9239i];
G29=[0            -0.9569 + 0.2903i;-0.2903 - 0.9569i        0];
G30=[ -0.9808 + 0.1951i        0;0            -0.1951 - 0.9808i];
G31=[0         -0.9952 + 0.0980i;-0.0980 - 0.9952i        0];
G32=[-1.0000 + 0.0000i        0;0            -0.0000 - 1.0000i];
G33=[0            -0.9952 - 0.0980i;0.0980 - 0.9952i        0];
G34=[-0.9808 - 0.1951i        0;0          0.1951 - 0.9808i];
G35=[0            -0.9569 - 0.2903i;0.2903 - 0.9569i        0];
G36=[-0.9239 - 0.3827i        0;0             0.3827 - 0.9239i];
G37=[0            -0.8819 - 0.4714i;0.4714 - 0.8819i        0];
G38=[-0.8315 - 0.5556i        0;0             0.5556 - 0.8315i];
G39=[ 0            -0.7730 - 0.6344i;0.6344 - 0.7730i        0];
G40=[-0.7071 - 0.7071i        0;0             0.7071 - 0.7071i];
G41=[0            -0.6344 - 0.7730i;0.7730 - 0.6344i        0];
G42=[-0.5556 - 0.8315i        0 ;0             0.8315 - 0.5556i];
G43=[ 0            -0.4714 - 0.8819i;0.8819 - 0.4714i        0 ];
G44=[-0.3827 - 0.9239i        0;0             0.9239 - 0.3827i];
G45=[0            -0.2903 - 0.9569i;0.9569 - 0.2903i        0];
G46=[-0.1951 - 0.9808i        0;0             0.9808 - 0.1951i];
G47=[0            -0.0980 - 0.9952i;0.9952 - 0.0980i        0];
G48=[-0.0000 - 1.0000i        0;0             1.0000 - 0.0000i];
G49=[0             0.0980 - 0.9952i;0.9952 + 0.0980i        0];
G50=[0.1951 - 0.9808i        0;0             0.9808 + 0.1951i];
G51=[0             0.2903 - 0.9569i;0.9569 + 0.2903i        0  ];
G52=[0.3827 - 0.9239i        0 ;0             0.9239 + 0.3827i];
G53=[0             0.4714 - 0.8819i;0.8819 + 0.4714i        0 ];
G54=[0.5556 - 0.8315i        0;0             0.8315 + 0.5556i];
G55=[0             0.6344 - 0.7730i;0.7730 + 0.6344i        0 ];
G56=[0.7071 - 0.7071i        0;0             0.7071 + 0.7071i];
G57=[0             0.7730 - 0.6344i;0.6344 + 0.7730i        0 ];
G58=[0.8315 - 0.5556i        0;  0             0.5556 + 0.8315i];
G59=[0             0.8819 - 0.4714i;0.4714 + 0.8819i        0 ];
G60=[0.9239 - 0.3827i        0 ; 0             0.3827 + 0.9239i];
G61=[ 0             0.9569 - 0.2903i;0.2903 + 0.9569i        0 ];
G62=[0.9808 - 0.1951i        0 ;0             0.1951 + 0.9808i];
G63=[0            0.9952 - 0.0980i; 0.0980 + 0.9952i        0];
G64=[ 0           0.9952 + 0.0980i; -0.0980 + 0.9952i        0];


len=length(bitsource)/6;
ugc_64qam=zeros(2,2*len);

for k=1:len
    if(bitsource(6*k-5)==0 & bitsource(6*k-4)==0 & bitsource(6*k-3)==0 & bitsource(6*k-2)==0 & bitsource(6*k-1)==0 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G1;
    elseif(bitsource(6*k-5)==0 & bitsource(6*k-4)==0 & bitsource(6*k-3)==0 & bitsource(6*k-2)==0 & bitsource(6*k-1)==0 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G2;
    elseif(bitsource(6*k-5)==0 & bitsource(6*k-4)==0 & bitsource(6*k-3)==0 & bitsource(6*k-2)==0 & bitsource(6*k-1)==1 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G3;
    elseif(bitsource(6*k-5)==0 & bitsource(6*k-4)==0 & bitsource(6*k-3)==0 & bitsource(6*k-2)==0 & bitsource(6*k-1)==1 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G4;
         
        
    elseif(bitsource(6*k-5)==0 & bitsource(6*k-4)==0 & bitsource(6*k-3)==0 & bitsource(6*k-2)==1 & bitsource(6*k-1)==0 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G5;
    elseif(bitsource(6*k-5)==0 & bitsource(6*k-4)==0 & bitsource(6*k-3)==0 & bitsource(6*k-2)==1 & bitsource(6*k-1)==0 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G6;
    elseif(bitsource(6*k-5)==0 & bitsource(6*k-4)==0 & bitsource(6*k-3)==0 & bitsource(6*k-2)==1 & bitsource(6*k-1)==1 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G7;
    elseif(bitsource(6*k-5)==0 & bitsource(6*k-4)==0 & bitsource(6*k-3)==0 & bitsource(6*k-2)==1 & bitsource(6*k-1)==1 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G8;
    elseif(bitsource(6*k-5)==0 & bitsource(6*k-4)==0 & bitsource(6*k-3)==1 & bitsource(6*k-2)==0 & bitsource(6*k-1)==0 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G9;
    elseif(bitsource(6*k-5)==0 & bitsource(6*k-4)==0 & bitsource(6*k-3)==1 & bitsource(6*k-2)==0 & bitsource(6*k-1)==0 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G10;
    elseif(bitsource(6*k-5)==0 & bitsource(6*k-4)==0 & bitsource(6*k-3)==1 & bitsource(6*k-2)==0 & bitsource(6*k-1)==1 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G11;
    elseif(bitsource(6*k-5)==0 & bitsource(6*k-4)==0 & bitsource(6*k-3)==1 & bitsource(6*k-2)==0 & bitsource(6*k-1)==1 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G12;
    elseif(bitsource(6*k-5)==0 & bitsource(6*k-4)==0 & bitsource(6*k-3)==1 & bitsource(6*k-2)==1 & bitsource(6*k-1)==0 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G13;
    elseif(bitsource(6*k-5)==0 & bitsource(6*k-4)==0 & bitsource(6*k-3)==1 & bitsource(6*k-2)==1 & bitsource(6*k-1)==0 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G14;
    elseif(bitsource(6*k-5)==0 & bitsource(6*k-4)==0 & bitsource(6*k-3)==1 & bitsource(6*k-2)==1 & bitsource(6*k-1)==1 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G15;
    elseif(bitsource(6*k-5)==0 & bitsource(6*k-4)==0 & bitsource(6*k-3)==1 & bitsource(6*k-2)==1 & bitsource(6*k-1)==1 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G16;
        
        
        
        
        elseif(bitsource(6*k-5)==0  & bitsource(6*k-4)==1 & bitsource(6*k-3)==0  & bitsource(6*k-2)==0 & bitsource(6*k-1)==0 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G17;
        elseif(bitsource(6*k-5)==0  & bitsource(6*k-4)==1 & bitsource(6*k-3)==0  & bitsource(6*k-2)==0 & bitsource(6*k-1)==0 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G18;
        elseif(bitsource(6*k-5)==0  & bitsource(6*k-4)==1 & bitsource(6*k-3)==0  & bitsource(6*k-2)==0 & bitsource(6*k-1)==1 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G19;
        elseif(bitsource(6*k-5)==0  & bitsource(6*k-4)==1 & bitsource(6*k-3)==0  & bitsource(6*k-2)==0 & bitsource(6*k-1)==1 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G20;
        elseif(bitsource(6*k-5)==0  & bitsource(6*k-4)==1 & bitsource(6*k-3)==0  & bitsource(6*k-2)==1 & bitsource(6*k-1)==0 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G21;
        elseif(bitsource(6*k-5)==0  & bitsource(6*k-4)==1 & bitsource(6*k-3)==0  & bitsource(6*k-2)==1 & bitsource(6*k-1)==0 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G22;
        elseif(bitsource(6*k-5)==0  & bitsource(6*k-4)==1 & bitsource(6*k-3)==0  & bitsource(6*k-2)==1 & bitsource(6*k-1)==1 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G23;
        elseif(bitsource(6*k-5)==0  & bitsource(6*k-4)==1 & bitsource(6*k-3)==0  & bitsource(6*k-2)==1 & bitsource(6*k-1)==1 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G24;
        elseif(bitsource(6*k-5)==0  & bitsource(6*k-4)==1 & bitsource(6*k-3)==1 & bitsource(6*k-2)==0 & bitsource(6*k-1)==0 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G25;
        elseif(bitsource(6*k-5)==0  & bitsource(6*k-4)==1 & bitsource(6*k-3)==1 & bitsource(6*k-2)==0 & bitsource(6*k-1)==0 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G26;
        elseif(bitsource(6*k-5)==0  & bitsource(6*k-4)==1 & bitsource(6*k-3)==1 & bitsource(6*k-2)==0 & bitsource(6*k-1)==1 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G27;
        elseif(bitsource(6*k-5)==0  & bitsource(6*k-4)==1 & bitsource(6*k-3)==1 & bitsource(6*k-2)==0 & bitsource(6*k-1)==1 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G28;
        elseif(bitsource(6*k-5)==0  & bitsource(6*k-4)==1 & bitsource(6*k-3)==1 & bitsource(6*k-2)==1 & bitsource(6*k-1)==0 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G29;
        elseif(bitsource(6*k-5)==0  & bitsource(6*k-4)==1 & bitsource(6*k-3)==1 & bitsource(6*k-2)==1 & bitsource(6*k-1)==0 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G30;
        elseif(bitsource(6*k-5)==0  & bitsource(6*k-4)==1 & bitsource(6*k-3)==1 & bitsource(6*k-2)==1 & bitsource(6*k-1)==1 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G31;
        elseif(bitsource(6*k-5)==0  & bitsource(6*k-4)==1 & bitsource(6*k-3)==1 & bitsource(6*k-2)==1 & bitsource(6*k-1)==1 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G32;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==0  & bitsource(6*k-3)==0  & bitsource(6*k-2)==0 & bitsource(6*k-1)==0 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G33;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==0  & bitsource(6*k-3)==0  & bitsource(6*k-2)==0 & bitsource(6*k-1)==0 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G34;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==0  & bitsource(6*k-3)==0  & bitsource(6*k-2)==0 & bitsource(6*k-1)==1 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G35;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==0  & bitsource(6*k-3)==0  & bitsource(6*k-2)==0 & bitsource(6*k-1)==1 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G36;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==0  & bitsource(6*k-3)==0  & bitsource(6*k-2)==1 & bitsource(6*k-1)==0 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G37;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==0  & bitsource(6*k-3)==0  & bitsource(6*k-2)==1 & bitsource(6*k-1)==0 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G38;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==0  & bitsource(6*k-3)==0  & bitsource(6*k-2)==1 & bitsource(6*k-1)==1 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G39;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==0  & bitsource(6*k-3)==0  & bitsource(6*k-2)==1 & bitsource(6*k-1)==1 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G40;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==0  & bitsource(6*k-3)==1 & bitsource(6*k-2)==0 & bitsource(6*k-1)==0 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G41;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==0  & bitsource(6*k-3)==1 & bitsource(6*k-2)==0 & bitsource(6*k-1)==0 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G42;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==0  & bitsource(6*k-3)==1 & bitsource(6*k-2)==0 & bitsource(6*k-1)==1 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G43;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==0  & bitsource(6*k-3)==1 & bitsource(6*k-2)==0 & bitsource(6*k-1)==1 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G44;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==0  & bitsource(6*k-3)==1 & bitsource(6*k-2)==1 & bitsource(6*k-1)==0 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G45;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==0  & bitsource(6*k-3)==1 & bitsource(6*k-2)==1 & bitsource(6*k-1)==0 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G46;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==0  & bitsource(6*k-3)==1 & bitsource(6*k-2)==1 & bitsource(6*k-1)==1 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G47;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==0  & bitsource(6*k-3)==1 & bitsource(6*k-2)==1 & bitsource(6*k-1)==1 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G48;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==1 & bitsource(6*k-3)==0  & bitsource(6*k-2)==0 & bitsource(6*k-1)==0 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G49;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==1 & bitsource(6*k-3)==0  & bitsource(6*k-2)==0 & bitsource(6*k-1)==0 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G50;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==1 & bitsource(6*k-3)==0  & bitsource(6*k-2)==0 & bitsource(6*k-1)==1 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G51;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==1 & bitsource(6*k-3)==0  & bitsource(6*k-2)==0 & bitsource(6*k-1)==1 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G52;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==1 & bitsource(6*k-3)==0  & bitsource(6*k-2)==1 & bitsource(6*k-1)==0 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G53;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==1 & bitsource(6*k-3)==0  & bitsource(6*k-2)==1 & bitsource(6*k-1)==0 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G54;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==1 & bitsource(6*k-3)==0  & bitsource(6*k-2)==1 & bitsource(6*k-1)==1 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G55;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==1 & bitsource(6*k-3)==0  & bitsource(6*k-2)==1 & bitsource(6*k-1)==1 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G56;
        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==1 & bitsource(6*k-3)==1 & bitsource(6*k-2)==0 & bitsource(6*k-1)==0 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G57;

        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==1 & bitsource(6*k-3)==1 & bitsource(6*k-2)==0 & bitsource(6*k-1)==0 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G58;

        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==1 & bitsource(6*k-3)==1 & bitsource(6*k-2)==0 & bitsource(6*k-1)==1 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G59;

        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==1 & bitsource(6*k-3)==1 & bitsource(6*k-2)==0 & bitsource(6*k-1)==1 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G60;

        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==1 & bitsource(6*k-3)==1 & bitsource(6*k-2)==1 & bitsource(6*k-1)==0 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G61;

        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==1 & bitsource(6*k-3)==1 & bitsource(6*k-2)==1 & bitsource(6*k-1)==0 & bitsource(6*k)==1)
        ugc_64qam(:,2*k-1:2*k)=G62;

        elseif(bitsource(6*k-5)==1 & bitsource(6*k-4)==1 & bitsource(6*k-3)==1 & bitsource(6*k-2)==1 & bitsource(6*k-1)==1 & bitsource(6*k)==0)
        ugc_64qam(:,2*k-1:2*k)=G63;           
        
        else
        ugc_64qam(:,2*k-1:2*k)=G64;
  
    end
end
