clc;
clear all;
close all;
format long;

frm_len=4500;
frm=24;

SNR_dB=0:1:24; %dB
snr=10.^(SNR_dB./10);
D=[1 -1;1 1];
count_error=0;
nr_bits=frm_len*frm;

bit_source=(rand(1, nr_bits) > .5);
b=reshape(bit_source,[],frm);
id=1;  %4 different modulations
%adapt_index=randsrc(1,30,[1 2 3])
adapt_order=[1];
ins_ber=[0];
hh=1;
for snr_idx=1:length(snr)
    ber_rnd=zeros(1,1);
    kk=0;
    round=1;
     
        
        for frame=1:frm % a big loop includes upsampling, pulse shaping, shift to 10KHz....
            b_frame=[b(:,frame)];
            %id=adapt_index(frame);
            %%%%%%%%%%%%%%%%%%%%       modulation         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
            count_error=0;
           
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
            X(:,3:frm_len/M*2+2)=dif_encoder(D,ugc_mpsk);
            branch1=X(1,:);
            branch2=X(2,:);
            len_x=size(branch1,2);
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  channel model     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            snr_per_tx=snr(snr_idx)/2;
             H=crandn(2,2);
%             lambda=3*10^8/10^9;
%             k=2*pi/lambda;
%             d1=10*lambda;
%             d2=3*lambda;
%             rr=[1 besselj(0,k*d1); besselj(0,k*d1) 1];
%             tt=[1 besselj(0,k*d2); besselj(0,k*d2) 1];
%            
%             r=sqrtm(rr);
%             t=sqrtm(tt);
%             
%             G=crandn(2,2);
%             H=r*G*t;
            
            
            Noise=crandn(2,len_x);
            
            Y=zeros(2,len_x);
            for i=1:len_x
                Y(:,i)=sqrt(snr_per_tx)*H*X(:,i)+Noise(:,i);
            end
            
            ins_sn1=var(Y(1,:))/var(Noise(1,:))/4;
            ins_sn2=var(Y(2,:))/var(Noise(2,:))/4;
            
            ins_snr=(ins_sn1+ins_sn2)/2;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    demodulation     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            
            b_hat=diff_dec_2x2(Y,M);
            
            for k=1:length(b_hat)
                if (b_hat(k) ~= b(k,frame)) 
                    count_error = count_error+1;
                end
            end
            
            % Adaptive mod: threasholds: 10e-2 & 10e-3 & 10e-4
            kk=count_error/frm_len;
       
%                                                if(kk>=0.1)
%                                                    id=1;
%                                                elseif(kk<0.1&kk>=0.01)
%                                                    id=2;
%                                                elseif(kk<0.01&kk>=0.004)
%                                                    id=3;
%                                                  else
%                                                    id=4;
%                                               end
%            if(kk>0.01)
%                 if(id~=1)
%                     id=1;
%                 end
%             
%             elseif(kk<0.0001)
%                 if(id~=4)
%                     id=id+1;
%                 end
%             elseif(kk<0.01 & kk>0.001)
%                 if(id~=1)
%                     id=id-1;
%                 end
%                 
%           end

                                               if(10*log10(ins_snr)<0.5) 
                                                   id=1;
                                               elseif(10*log10(ins_snr)>0.5&10*log10(ins_snr)<3)
                                                   id=1;
                                               elseif(10*log10(ins_snr)>3&10*log10(ins_snr)<10)
                                                   id=2;
                                               elseif(10*log10(ins_snr)>10&10*log10(ins_snr)<15)
                                                   id=3;
                                               else    %if(ins_snr>15&ins_snr<150 )
                                                   id=4;
                                              end

SNR_ins(hh)=ins_snr;
hh=hh+1;
                   Adapt_order(frame)=id;  
                   ins_ber=[ins_ber kk];
         
        end % for frame
        ber_rnd(round)=count_error/nr_bits;
        
         adapt_order=[adapt_order Adapt_order];
        %         figure
        %         plot(id_buff,'-s');
        %         title('changing of Modulation')
    % for round
    ber(snr_idx)=mean(ber_rnd);
end %for snr

figure
semilogy(SNR_dB,ber,'r-s')
grid on
title('DSTM 2x2  (BER vs SNR)');

figure, subplot(211); plot(ins_ber);title('Ins BER')
subplot(212);stem(adapt_order);title('Adaptive modulation order');

% semilogy(SNR_dB,ber_mod(:,1),'r-s',SNR_dB,ber_mod(:,2),'-s',SNR_dB,ber_mod(:,3),'bla-s')
% xlabel('SNR(dB)')
% ylabel('BER')
% title('Differential Space-time Modulation')
% grid on