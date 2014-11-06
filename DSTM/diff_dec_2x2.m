function out=diff_dec_2x2(Y,m)

% m refers to the modulation level , m=1-> BPSK,  m=2-> QPSK, m=3 -> 8PSK

D=[1 -1 ; 1 1];


r1_I=real(Y(1,:));
r1_Q=imag(Y(1,:));
r2_I=real(Y(2,:));
r2_Q=imag(Y(2,:));

len= length(r1_I)/2;

%if m=2 then the G matrices are as follows
% b=1 -> G1=[-1 0; 0 -1];   
% b=0 -> G2=[1 0; 0 1];

switch(m)
case 1   
    %case for bpsk modulation
    G1=[-1 0; 0 -1];
    G2=[1 0; 0 1];
    out=zeros(1,len-1);
    for i=1:len
        if (i==1)
            Yprev=[r1_I(2*i-1)+j*r1_Q(2*i-1)  r1_I(2*i)+j*r1_Q(2*i);r2_I(2*i-1)+j*r2_Q(2*i-1)  r2_I(2*i)+j*r2_Q(2*i)];
            %Y is defined as [Rx1(t) Rx1(t+T),Rx2(t) Rx2(t+T)];
            
            %      s0=real(trace(D*G1*Y'));
            %      s1=real(trace(D*G2*Y'));
            
        else
            Y=[r1_I(2*i-1)+j*r1_Q(2*i-1)  r1_I(2*i)+j*r1_Q(2*i);r2_I(2*i-1)+j*r2_Q(2*i-1)  r2_I(2*i)+j*r2_Q(2*i)];
            %Y is defined as [Rx1(t) Rx1(t+T);Rx2(t) Rx2(t+T)];
            
            b0=real(trace(G1 * Y'* Yprev));
            b1=real(trace(G2 * Y'* Yprev));
            
            
            if (b0>=b1)
                out(i-1)=1;
            else
                out(i-1)=0;
            end
            Yprev=Y;
        end
    end
case 2
    out=zeros(1,2*(len-1));
    
    %if m=2 then the G matrices are as follows
    % b= 00 -> G1=[1 0;0 1];   
    % b= 01 -> G2=[j 0;0 -j];
    % b= 10 -> G3=[0 1;-1 0];
    % b= 11 -> G4=[0 j;j 0];
    G1=[1 0;0 1];   
 G2=[j 0;0 -j];
 G3=[0 1;-1 0];
 G4=[0 j;j 0];
      
    ref=[ 0 0; 0 1; 1 0; 1 1];
   %load('QPSK_G.mat');
    for i=1:len
        if (i==1)
            Yprev=[r1_I(2*i-1)+j*r1_Q(2*i-1)  r1_I(2*i)+j*r1_Q(2*i);r2_I(2*i-1)+j*r2_Q(2*i-1)  r2_I(2*i)+j*r2_Q(2*i)];
            %Y is defined as [Rx1(t) Rx1(t+T),Rx2(t) Rx2(t+T)];
            
            
            
        else
            Y=[r1_I(2*i-1)+j*r1_Q(2*i-1)  r1_I(2*i)+j*r1_Q(2*i);r2_I(2*i-1)+j*r2_Q(2*i-1)  r2_I(2*i)+j*r2_Q(2*i)];
            %Y is defined as [Rx1(t) Rx1(t+T),Rx2(t) Rx2(t+T)];
            b(1)=real(trace(G1*Y'*Yprev));
            b(2)=real(trace(G2*Y'*Yprev));
            b(3)=real(trace(G3*Y'*Yprev));
            b(4)=real(trace(G4*Y'*Yprev));
           
            [A,B]=max(b);
            out(i*2-3:i*2-2)=ref(B,:);
            Yprev=Y;
        end
    end
    
case 3   %case for qpsk modulation
    out=zeros(1,3*(len-1));
    
    %if m=2 then the G matrices are as follows
    % b= 000 -> G1=[1 0;0 1];   
    % b= 001 -> G2=[j 0;0 -j];
    % b= 010 -> G3=[0 1;-1 0];
    % b= 011 -> G4=[0 j;j 0];
    % b= 100 -> G5=[-1 0;0 -1];
    % b= 101 -> G6=[-j 0;0 j];
    % b= 110 -> G7=[0 -1;1 0];
    % b= 111 -> G8=[0 -j; -j 0];
    
    ref=[0 0 0;0 0 1;0 1 0;0 1 1;1 0 0;1 0 1;1 1 0;1 1 1];
    load('QPSK_G.mat');
    for i=1:len
        if (i==1)
            Yprev=[r1_I(2*i-1)+j*r1_Q(2*i-1)  r1_I(2*i)+j*r1_Q(2*i);r2_I(2*i-1)+j*r2_Q(2*i-1)  r2_I(2*i)+j*r2_Q(2*i)];
            %Y is defined as [Rx1(t) Rx1(t+T),Rx2(t) Rx2(t+T)];
            
            
            
        else
            Y=[r1_I(2*i-1)+j*r1_Q(2*i-1)  r1_I(2*i)+j*r1_Q(2*i);r2_I(2*i-1)+j*r2_Q(2*i-1)  r2_I(2*i)+j*r2_Q(2*i)];
            %Y is defined as [Rx1(t) Rx1(t+T),Rx2(t) Rx2(t+T)];
            b(1)=real(trace(G1*Y'*Yprev));
            b(2)=real(trace(G2*Y'*Yprev));
            b(3)=real(trace(G3*Y'*Yprev));
            b(4)=real(trace(G4*Y'*Yprev));
            b(5)=real(trace(G5*Y'*Yprev));
            b(6)=real(trace(G6*Y'*Yprev));
            b(7)=real(trace(G7*Y'*Yprev));
            b(8)=real(trace(G8*Y'*Yprev));
            [A,B]=max(b);
            out(i*3-5:i*3-3)=ref(B,:);
            Yprev=Y;
        end
    end
    
case 4
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
    out=zeros(1,4*(len-1));
    for i=1:len
        if (i==1)
            Yprev=[r1_I(2*i-1)+j*r1_Q(2*i-1)  r1_I(2*i)+j*r1_Q(2*i);r2_I(2*i-1)+j*r2_Q(2*i-1)  r2_I(2*i)+j*r2_Q(2*i)];
        else
            Y=[r1_I(2*i-1)+j*r1_Q(2*i-1)  r1_I(2*i)+j*r1_Q(2*i);r2_I(2*i-1)+j*r2_Q(2*i-1)  r2_I(2*i)+j*r2_Q(2*i)];
            b(1)=real(trace(G1*Y'*Yprev));
            b(2)=real(trace(G2*Y'*Yprev));
            b(3)=real(trace(G3*Y'*Yprev));
            b(4)=real(trace(G4*Y'*Yprev));
            b(5)=real(trace(G5*Y'*Yprev));
            b(6)=real(trace(G6*Y'*Yprev));
            b(7)=real(trace(G7*Y'*Yprev));
            b(8)=real(trace(G8*Y'*Yprev));
            b(9)=real(trace(G9*Y'*Yprev));
            b(10)=real(trace(G10*Y'*Yprev));
            b(11)=real(trace(G11*Y'*Yprev));
            b(12)=real(trace(G12*Y'*Yprev));
            b(13)=real(trace(G13*Y'*Yprev));
            b(14)=real(trace(G14*Y'*Yprev));
            b(15)=real(trace(G15*Y'*Yprev));
            b(16)=real(trace(G16*Y'*Yprev));
            [A,B]=max(b);
            ref=[0 0 0 0;0 0 0 1;0 0 1 0;0 0 1 1;0 1 0 0;0 1 0 1;0 1 1 0;0 1 1 1;1 0 0 0;1 0 0 1;1 0 1 0;1 0 1 1;1 1 0 0;1 1 0 1;1 1 1 0;1 1 1 1];
            out(i*4-7:i*4-4)=ref(B,:);
            Yprev=Y;
        end
    end
    
    case 5
    
    case 6
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

out=zeros(1,6*(len-1));
    
for i=1:len
        if (i==1)
            Yprev=[r1_I(2*i-1)+j*r1_Q(2*i-1)  r1_I(2*i)+j*r1_Q(2*i);r2_I(2*i-1)+j*r2_Q(2*i-1)  r2_I(2*i)+j*r2_Q(2*i)];
        else
            Y=[r1_I(2*i-1)+j*r1_Q(2*i-1)  r1_I(2*i)+j*r1_Q(2*i);r2_I(2*i-1)+j*r2_Q(2*i-1)  r2_I(2*i)+j*r2_Q(2*i)];
            b(1)=real(trace(G1*Y'*Yprev));
            b(2)=real(trace(G2*Y'*Yprev));
            b(3)=real(trace(G3*Y'*Yprev));
            b(4)=real(trace(G4*Y'*Yprev));
            b(5)=real(trace(G5*Y'*Yprev));
            b(6)=real(trace(G6*Y'*Yprev));
            b(7)=real(trace(G7*Y'*Yprev));
            b(8)=real(trace(G8*Y'*Yprev));
            b(9)=real(trace(G9*Y'*Yprev));
            b(10)=real(trace(G10*Y'*Yprev));
            b(11)=real(trace(G11*Y'*Yprev));
            b(12)=real(trace(G12*Y'*Yprev));
            b(13)=real(trace(G13*Y'*Yprev));
            b(14)=real(trace(G14*Y'*Yprev));
            b(15)=real(trace(G15*Y'*Yprev));
            b(16)=real(trace(G16*Y'*Yprev));
            
            b(17)=real(trace(G17*Y'*Yprev));
            b(18)=real(trace(G18*Y'*Yprev));
            b(19)=real(trace(G19*Y'*Yprev));
            b(20)=real(trace(G20*Y'*Yprev));
            b(21)=real(trace(G21*Y'*Yprev));
            b(22)=real(trace(G22*Y'*Yprev));
            b(23)=real(trace(G23*Y'*Yprev));
            b(24)=real(trace(G24*Y'*Yprev));
            b(25)=real(trace(G25*Y'*Yprev));
            b(26)=real(trace(G26*Y'*Yprev));
            b(27)=real(trace(G27*Y'*Yprev));
            b(28)=real(trace(G28*Y'*Yprev));
            b(29)=real(trace(G29*Y'*Yprev));
            b(30)=real(trace(G30*Y'*Yprev));
            b(31)=real(trace(G31*Y'*Yprev));
            b(32)=real(trace(G32*Y'*Yprev));
            
            b(33)=real(trace(G33*Y'*Yprev));
            b(34)=real(trace(G34*Y'*Yprev));
            b(35)=real(trace(G35*Y'*Yprev));
            b(36)=real(trace(G36*Y'*Yprev));
            b(37)=real(trace(G37*Y'*Yprev));
            b(38)=real(trace(G38*Y'*Yprev));
            b(39)=real(trace(G39*Y'*Yprev));
            b(40)=real(trace(G40*Y'*Yprev));
            b(41)=real(trace(G41*Y'*Yprev));
            b(42)=real(trace(G42*Y'*Yprev));
            b(43)=real(trace(G43*Y'*Yprev));
            b(44)=real(trace(G44*Y'*Yprev));
            b(45)=real(trace(G45*Y'*Yprev));
            b(46)=real(trace(G46*Y'*Yprev));
            b(47)=real(trace(G47*Y'*Yprev));
            b(48)=real(trace(G48*Y'*Yprev));
            
            b(49)=real(trace(G49*Y'*Yprev));
            b(50)=real(trace(G50*Y'*Yprev));
            b(51)=real(trace(G51*Y'*Yprev));
            b(52)=real(trace(G52*Y'*Yprev));
            b(53)=real(trace(G53*Y'*Yprev));
            b(54)=real(trace(G54*Y'*Yprev));
            b(55)=real(trace(G55*Y'*Yprev));
            b(56)=real(trace(G56*Y'*Yprev));
            b(57)=real(trace(G57*Y'*Yprev));
            b(58)=real(trace(G58*Y'*Yprev));
            b(59)=real(trace(G59*Y'*Yprev));
            b(60)=real(trace(G60*Y'*Yprev));
            b(61)=real(trace(G61*Y'*Yprev));
            b(62)=real(trace(G62*Y'*Yprev));
            b(63)=real(trace(G63*Y'*Yprev));
            b(64)=real(trace(G64*Y'*Yprev));
            
           [A,B]=max(b);
           ref=[0 0 0 0 0 0;
                0 0 0 0 0 1; 
                0 0 0 0 1 0;
                0 0 0 0 1 1;
                0 0 0 1 0 0;
                0 0 0 1 0 1;
                0 0 0 1 1 0;
                0 0 0 1 1 1;
                0 0 1 0 0 0;
                0 0 1 0 0 1;
                0 0 1 0 1 0;
                0 0 1 0 1 1;
                0 0 1 1 0 0;
                0 0 1 1 0 1;
                0 0 1 1 1 0;
                0 0 1 1 1 1;
                0 1 0 0 0 0;
                0 1 0 0 0 1; 
                0 1 0 0 1 0;
                0 1 0 0 1 1;
                0 1 0 1 0 0;
                0 1 0 1 0 1;
                0 1 0 1 1 0;
                0 1 0 1 1 1;
                0 1 1 0 0 0;
                0 1 1 0 0 1;
                0 1 1 0 1 0;
                0 1 1 0 1 1;
                0 1 1 1 0 0;
                0 1 1 1 0 1;
                0 1 1 1 1 0;
                0 1 1 1 1 1;
                1 0 0 0 0 0;
                1 0 0 0 0 1; 
                1 0 0 0 1 0;
                1 0 0 0 1 1;
                1 0 0 1 0 0;
                1 0 0 1 0 1;
                1 0 0 1 1 0;
                1 0 0 1 1 1;
                1 0 1 0 0 0;
                1 0 1 0 0 1;
                1 0 1 0 1 0;
                1 0 1 0 1 1;
                1 0 1 1 0 0;
                1 0 1 1 0 1;
                1 0 1 1 1 0;
                1 0 1 1 1 1;
                1 1 0 0 0 0;
                1 1 0 0 0 1; 
                1 1 0 0 1 0;
                1 1 0 0 1 1;
                1 1 0 1 0 0;
                1 1 0 1 0 1;
                1 1 0 1 1 0;
                1 1 0 1 1 1;
                1 1 1 0 0 0;
                1 1 1 0 0 1;
                1 1 1 0 1 0;
                1 1 1 0 1 1;
                1 1 1 1 0 0;
                1 1 1 1 0 1;
                1 1 1 1 1 0;
                1 1 1 1 1 1];
            out(i*6-11:i*6-6)=ref(B,:);
            Yprev=Y;
        end
    end
    
    
    
end
end