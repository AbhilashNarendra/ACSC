clear all;
close all;

frm_len=408;
frm=24;
nr_round=1%10;
SNR_dB=5:2.5:20; %dB
snr=10.^(SNR_dB./10);
D=[1 -1;1 1];
count_error=0;
nr_bits=frm_len*frm;

bit_source=(rand(1, nr_bits) > .5);
b=reshape(bit_source,[],frm);
AXX=[2]
id=1;  % To change among 3 different modulations
for snr_idx=1:length(snr)
    ber_rnd=zeros(1,nr_round);
    for round=1:nr_round
        id=2;
        
        for frame=1:frm % a big loop includes upsampling, pulse shaping, shift to 10KHz....
            b_frame=[b(:,frame)];
            count_error=0;
            %%%%%%%%%%%%%%%%%%%%       modulation         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            if(id == 1)
                [ugc_mpsk]=ugc_encoder_bpsk(b_frame);
                M=1;
            elseif(id == 2)
                [ugc_mpsk]=ugc_encoder_qpsk(b_frame);
                M=3;
            elseif(id == 3)
                [ugc_mpsk]=ugc_encoder_8psk(b_frame);   
                M=4;
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
            Noise=crandn(2,len_x);
            Y=zeros(2,len_x);
            for i=1:len_x
                Y(:,i)=sqrt(snr_per_tx)*H*X(:,i)+Noise(:,i);
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    demodulation     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            err_per_frm=0;
            b_hat=diff_dec_2x2(Y,M);
            
            for k=1:length(b_hat)
                if (b_hat(k) ~= b(k,frame)) 
                    count_error = count_error+1;
                    err_per_frm=err_per_frm+1;
                end
            end
            
            % Adaptive mod: threasholds: 10e-2 & 10e-3 & 10e-4
            
            id_buff(frame)=id;
            if(err_per_frm/frm_len>0.01)
                if(id~=1)
                    id=1;
                end
            
            elseif(err_per_frm/frm_len<0.0001)
                if(id~=3)
                    id=id+1;
                end
            elseif(err_per_frm/frm_len<0.01 & err_per_frm/frm_len>0.001)
                if(id~=1)
                    id=id-1;
                end
                
                
            end
            AXX=[AXX id_buff];
            %frame=frame+1;
        end % for frame
        ber_rnd(round)=count_error/nr_bits;
        
        %         figure
        %         plot(id_buff,'-s');
        %         title('changing of Modulation')
    end% for round
    ber(snr_idx)=mean(ber_rnd);
end %for snr

figure
semilogy(SNR_dB,ber,'r-s')
grid on
% semilogy(SNR_dB,ber_mod(:,1),'r-s',SNR_dB,ber_mod(:,2),'-s',SNR_dB,ber_mod(:,3),'bla-s')
% xlabel('SNR(dB)')
% ylabel('BER')
% title('Differential Space-time Modulation')
% grid on