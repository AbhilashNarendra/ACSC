function [down_conv_I,down_conv_Q]=down_conv(rx,fc,fs)
%
% (I*cos-Q*sin)*2*(cos-j*sin) ==> LPF ==> I+j*Q
%
rx_len=length(rx);

for k=1:rx_len
    down_conv_I(k)=2*cos(2*pi*fc/fs*k)*rx(k);
    down_conv_Q(k)=-2*sin(2*pi*fc/fs*k)*rx(k);
end
