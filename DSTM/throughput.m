a_m=[1   1   1   1     1     2     1     2     1    2  3     4     1     2     3     2     3     4     1     2     3     4     4     4     4     3];
Thp=[];
for i=1:length(a_m)
if (a_m(i)==1)
    Thp(i)=1;
elseif(a_m(i)==2)
    Thp(i)=2;
    
elseif(a_m(i)==3)
    Thp(i)=4;
    
elseif(a_m(i)==4)
    Thp(i)=6;
end
end

stem(0:1:25,Thp);
title('Throughput');
ylabel('bits/symbol (BPS)');
xlabel('SNR(dB)');