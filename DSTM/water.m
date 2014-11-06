% water filling to calculate the power weights
function [W,Lw_1,Lw_2]=water(H,noise_var);

[U,S,V] = svd(H);

Uw=V;
Vw=eye(2); 

Ms=2;
sum1=1/S(1,1)^2+1/S(2,2)^2; 
E=(1+noise_var*sum1)/Ms;
Lw_1=E-noise_var/S(1,1)^2;  %lambda..
Lw_2=E-noise_var/S(2,2)^2;
if(Lw_2<=0)
   Ms=Ms-1;
   E=(1+noise_var/S(1,1)^2)/Ms;
   Lw_1=E-noise_var/S(1,1)^2;
   Lw_2=0;
   if(Lw_1<=0)
       Lw_1=1;         % need modification
   end
end
Lw_1=sqrt(Lw_1);
Lw_2=sqrt(Lw_2); 
Sw=[Lw_1 0;0 Lw_2];    
W=Uw*Sw*Vw'; 
