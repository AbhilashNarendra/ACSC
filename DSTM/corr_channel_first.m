lambda=3*10^8/10^9;
            k=2*pi/lambda;
            d1=10*lambda;
            d2=3*lambda;
            rr=[1 besselj(0,k*d1); besselj(0,k*d1) 1];
            tt=[1 besselj(0,k*d2); besselj(0,k*d2) 1];
           
            r=chol(rr);
            t=chol(tt);
            HH=[];
            for i=1:100
            G=crandn(2,2);
            H=r*G*t;
            HH=[HH reshape(H,1,4)];
            end
            