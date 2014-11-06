
alp=0.99;
K=4
H=(randn(K/2,2)+j*randn(K/2,2));%/sqrt(2);
    coe=chol([1 alp; alp 1]); % alp is the correlation coefficient
    coe=coe.';
    H=H.';
    H=coe*H 