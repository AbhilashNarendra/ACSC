%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script for simulating M-QAM (4-QAM, 16-QAM, 64-QAM, 256QAM, 1024QAM) 
% transmission and reception and compare the simulated and theoretical 
% symbol error probability

clear
N =  7*10^4; % number of symbols
M = 64; % number of constellation points      

k = sqrt(1/((2/3)*(M-1))); % normalizing factor

m = [1:sqrt(M)/2]; % alphabets
alphaMqam = [-(2*m-1) 2*m-1]; 

Es_N0_dB = [0:20]; % multiple Es/N0 values

ipHat = zeros(1,N); % init

for ii = 1:length(Es_N0_dB)

    ip = randsrc(1,N,alphaMqam) + j*randsrc(1,N,alphaMqam);
    s = k*ip; % normalization of energy to 1
    n = 1/sqrt(2)*[randn(1,N) + j*randn(1,N)]; % white guassian noise, 0dB variance

    y = s + 10^(-Es_N0_dB(ii)/20)*n; % additive white gaussian noise

    % demodulation
    y_re = real(y)/k; % real part
    y_im = imag(y)/k; % imaginary part
    
    % rounding to the nearest alphabet
    % 0 to 2 --> 1
    % 2 to 4 --> 3
    % 4 to 6 --> 5 etc
    ipHat_re = 2*floor(y_re/2)+1;
    ipHat_re(find(ipHat_re>max(alphaMqam))) = max(alphaMqam);
    ipHat_re(find(ipHat_re<min(alphaMqam))) = min(alphaMqam);
	     
    % rounding to the nearest alphabet
    % 0 to 2 --> 1
    % 2 to 4 --> 3
    % 4 to 6 --> 5 etc
    ipHat_im = 2*floor(y_im/2)+1;
    ipHat_im(find(ipHat_im>max(alphaMqam))) = max(alphaMqam);
    ipHat_im(find(ipHat_im<min(alphaMqam))) = min(alphaMqam);
    
    ipHat = ipHat_re + j*ipHat_im; 
    nErr(ii) = size(find([ip- ipHat]),2); % counting the number of errors

end

simSer = nErr/N;
theorySer = 2*(1-1/sqrt(M))*erfc(k*sqrt((10.^(Es_N0_dB/10)))) ...
              - (1-2/sqrt(M) + 1/M)*(erfc(k*sqrt((10.^(Es_N0_dB/10))))).^2;
close all
figure
semilogy(Es_N0_dB,theorySer,'bs-','LineWidth',2);
hold on
semilogy(Es_N0_dB,simSer,'m*-','Linewidth',1);
axis([0 30 10^-5 1])
grid on
legend('theory', 'simulation');
xlabel('Es/No, dB')
ylabel('Symbol Error Rate')
title('Symbol error probability curve for 64-QAM modulation')

