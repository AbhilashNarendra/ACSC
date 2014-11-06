m=2;
Y=[1 +1i 2+ 3i 4+ 5i 6+ 7i 8+ 2i 3+ 4i 5+ 6i 7+ 8i 1+ 4i ;1+ 4i 6+ 7i  8+ 6i 3+ 5i 6 +7i 1+ 4i  1+1i 2+5i 4+ 7i  ];
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
            out(i*3-3:i*3-2)=ref(B,:);
            Yprev=Y;
        end
    end
    
end
    

    
