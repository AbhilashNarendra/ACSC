clc;
clear all;
close all;

frm_len=360;     % input bits are taken in frames of length in bits
frm=40;  % number of frames

SNR_dB=0:1:15;      %dB
snr=10.^(SNR_dB./10);  %snr in linear scale
D=[1 -1;1 1];
count_error=0;
nr_bits=frm_len*frm;

bit_source=(rand(1, nr_bits) > .5);
b=reshape(bit_source,[],frm);
id=1;  %4 different modulations
%adapt_index=randsrc(1,30,[1 2 3])
adapt_order=[1];
ins_ber=[0];
for snr_idx=1:length(snr)
    ber_rnd=zeros(1,1);
    kk=0;
    round=1;
     id=1;
        count_error=0;
        for frame=1:frm % a big loop includes upsampling, pulse shaping, shift to 10KHz....
            b_frame=[b(:,frame)];
            %id=adapt_index(frame);
            %%%%%%%%%%%%%%%%%%%%       modulation         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
      
           
            if(id == 1)
                [ugc_mpsk]=ugc_encoder_bpsk(b_frame);
                M=1;
            elseif(id == 2)
%                 [ugc_mpsk]=ugc_encoder_qpsk(b_frame);
%                 M=3;
                   [ugc_mpsk]=ugc_encoder_4qam(b_frame);
                   M=2;
            elseif(id == 3)
                [ugc_mpsk]=ugc_encoder_8psk(b_frame);   
                M=4;
            elseif(id == 4)
                [ugc_mpsk]=ugc_encoder_64qam(b_frame);
                M=6;
            end
            X=zeros(2,frm_len/M*2+2);
            X(:,1:2)=D;
            X(:,3:frm_len/M*2+2)=dif_encoder(D,ugc_mpsk);  % differential encoding
            
            branch1=X(1,:);
            branch2=X(2,:);
            len_x=size(branch1,2);
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% correlated channel model     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            snr_per_tx=snr(snr_idx)/2;
             H=crandn(2,2);
%             lambda=3*10^8/10^9;
 %           k=2*pi/lambda;
 %            d1=10*lambda;
 %            d2=3*lambda;
  %           rr=[1 besselj(0,k*d1); besselj(0,k*d1) 1];
 %            tt=[1 besselj(0,k*d2); besselj(0,k*d2) 1];
            
   %          r=sqrtm(rr);
 %            t=sqrtm(tt);
             
 %            G=crandn(2,2);
   %          H=r*G*t;
            
            
            
            Noise=crandn(2,len_x);
            Y=zeros(2,len_x);
            for i=1:len_x
                Y(:,i)=sqrt(snr_per_tx)*H*X(:,i)+Noise(:,i);
            end
            
                       
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    demodulation     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            
            b_hat=diff_dec_2x2(Y,M);
            
            for k=1:length(b_hat)
                if (b_hat(k) ~= b(k,frame)) 
                    count_error = count_error+1;
                end
            end
            frame_err=0;
            for k=1:length(b_hat)
                if (b_hat(k) ~= b(k,frame)) 
                    frame_err = frame_err+1;
                end
            end
            
            
            kk=frame_err/frm_len;  
%                 
%           end
                     
                   Adapt_order(frame)=id;  
                   ins_ber=[ins_ber kk];
         
        end % for frames
        ber_rnd(round)=count_error/nr_bits;
        
         adapt_order=[adapt_order Adapt_order];
        
    ber(snr_idx)=mean(ber_rnd);
end %for snr

figure
semilogy(SNR_dB,ber,'r-s')
grid on
title('DSTM 2x2  (BER vs SNR)');

% figure, subplot(211); plot(ins_ber);title('Ins BER')
% subplot(212);stem(adapt_order);title('Adaptive modulation order');

% semilogy(SNR_dB,ber_mod(:,1),'r-s',SNR_dB,ber_mod(:,2),'-s',SNR_dB,ber_mod(:,3),'bla-s')
% xlabel('SNR(dB)')
% ylabel('BER')
% title('Differential Space-time Modulation')
% grid on