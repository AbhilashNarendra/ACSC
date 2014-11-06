function out=diff_dec(Y,m)

% m refers to the modulation level , m=1-> BPSK,  m=2-> QPSK, m=3 -> 8PSK

D=[1 -1 ; 1 1];


r1_I=real(Y);
r1_Q=imag(Y);

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
            Yprev=[r1_I(2*i-1)+j*r1_Q(2*i-1)  r1_I(2*i)+j*r1_Q(2*i)];
            %Y is defined as [Rx1(t) Rx1(t+T),Rx2(t) Rx2(t+T)];
            
            %      s0=real(trace(D*G1*Y'));
            %      s1=real(trace(D*G2*Y'));
            
        else
            Y=[r1_I(2*i-1)+j*r1_Q(2*i-1)  r1_I(2*i)+j*r1_Q(2*i)];
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
            Yprev=[r1_I(2*i-1)+j*r1_Q(2*i-1)  r1_I(2*i)+j*r1_Q(2*i)];
            %Y is defined as [Rx1(t) Rx1(t+T),Rx2(t) Rx2(t+T)];
            
            
            
        else
            Y=[r1_I(2*i-1)+j*r1_Q(2*i-1)  r1_I(2*i)+j*r1_Q(2*i)];
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
            Yprev=[r1_I(2*i-1)+j*r1_Q(2*i-1)  r1_I(2*i)+j*r1_Q(2*i)];
        else
            Y=[r1_I(2*i-1)+j*r1_Q(2*i-1)  r1_I(2*i)+j*r1_Q(2*i)];
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
end
end