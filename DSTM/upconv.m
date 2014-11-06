function tx=upconv(shaped_branch,fc,fs)
% up conversion is Re{(in_I+j*in_Q) * (cos+j*sin)}
data_len=length(shaped_branch);

in_I=real(shaped_branch);
in_Q=imag(shaped_branch);

for k=1:data_len
    tx(k)=cos(2*pi*fc/fs*k)*in_I(k) - sin(2*pi*fc/fs*k)*in_Q(k);
end