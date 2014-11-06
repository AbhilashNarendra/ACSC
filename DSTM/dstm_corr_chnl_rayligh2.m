clear all;
close all;

frm_len=1500;
frm=20;
nr_round=1;
SNR_dB=-5:1:25; %dB
snr=10.^(SNR_dB./10);
D=[1 -1;1 1];
count_error=0;
nr_bits=frm_len*frm;

bit_source=(rand(1, nr_bits) > .5);
b=reshape(bit_source,[],frm);
id=1;  %  3 different modulations
%adapt_index=randsrc(1,30,[1 2 3])
adapt_order=[1];
ins_ber=[0];







for snr_idx=1:length(snr)
    ber_rnd=zeros(1,nr_round);
    kk=0;
    for round=1:nr_round
     
        
        for frame=1:frm % a big loop includes upsampling, pulse shaping, shift to 10KHz....
            b_frame=[b(:,frame)];
            %id=adapt_index(frame);
            %%%%%%%%%%%%%%%%%%%%       modulation         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
            count_error=0;
            
            if(id == 1)
                [ugc_mpsk]=ugc_encoder_bpsk(b_frame);
                M=1;
            elseif(id == 2)
                [ugc_mpsk]=ugc_encoder_qpsk(b_frame);
                M=3;
%                    [ugc_mpsk]=ugc_encoder_4qam(b_frame);
%                    M=2;
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
            
            
           
alp=0.19;
K=4;
H=(randn(K/2,2)+j*randn(K/2,2))/sqrt(2);
    coe=chol([1 alp; alp 1]); % alp is the correlation coefficient
    coe=coe.';
    H=H.';
    H=coe*H ;
            
            
            
            Noise=crandn(2,len_x);
            Y=zeros(2,len_x);
            for i=1:len_x
                Y(:,i)=sqrt(snr_per_tx)*H*X(:,i)+Noise(:,i);
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    demodulation     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             kkkk=inv(H);
%             for i=1:len_x  % if channel matrix is known to receiver then 
%                 Y(:,i)=kkkk*Y(:,i);
%             end 
            
            
            
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
          if(kk>0.01)
                if(id~=1)
                    id=1;
                end
            
            elseif(kk<0.0001)
                if(id~=4)
                    id=id+1;
                end
            elseif(kk<0.01 & kk>0.001)
                if(id~=1)
                    id=id-1;
                end
                
          end

                          
                   Adapt_order(frame)=id;  
                   ins_ber=[ins_ber kk];
         
        end % for frame
        ber_rnd(round)=count_error/nr_bits;
        
         adapt_order=[adapt_order Adapt_order];
        %         figure
        %         plot(id_buff,'-s');
        %         title('changing of Modulation')
    end% for round
    ber(snr_idx)=mean(ber_rnd);
end %for snr

figure
semilogy(SNR_dB,ber,'r-s')
grid on
title('DSTBC 2x2  (BER vs SNR)');

figure, subplot(211); plot(ins_ber);title('Ins BER')
subplot(212);stem(adapt_order);title('Adaptive modulation order');
% semilogy(SNR_dB,ber_mod(:,1),'r-s',SNR_dB,ber_mod(:,2),'-s',SNR_dB,ber_mod(:,3),'bla-s')
% xlabel('SNR(dB)')
% ylabel('BER')
% title('Differential Space-time Modulation')
% grid on