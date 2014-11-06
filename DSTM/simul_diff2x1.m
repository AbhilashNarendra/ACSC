
% function  diff_st(mod_id,frm_len,frm)
% if nargin == 1
frm_len=100;
frm=10;
% elseif nargin == 2
%     frm=10;
%     
% end
for id=1:3
    
    
    if(id==1)
        M=1;
    elseif(id==2)
        M=3;
    elseif(id==3)
        M=4;
    end
    
    SNR_dB=2.5:2.5:20;
    SNR=10.^(SNR_dB./10); %1.7783    3.1623    5.6234   10.0000   17.7828   31.6228     56.2341  100.0000
    D=[1 -1;1 1];
    count_error=0;
    nr_bits=frm_len*frm;
    
    bit_source=(rand(1, nr_bits) > .5);
    b=reshape(bit_source,[],frm);
    for snr_id=1:length(SNR_dB)
        for round=1:20
            for frame=1:frm % a big loop includes upsampling, pulse shaping, shift to 10KHz....
                b_frame=[b(:,frame)];
                
                %%%%%%%%%%%%%%%%%%%%       modulation         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                if(id == 1)
                    [ugc_mpsk]=ugc_encoder_bpsk(b_frame);
                elseif(id == 2)
                    [ugc_mpsk]=ugc_encoder_qpsk(b_frame);
                elseif(id == 3)
                    [ugc_mpsk]=ugc_encoder_8psk(b_frame);   
                end
                X=zeros(2,frm_len/M*2+2);
                X(:,1:2)=D;
                X(:,3:frm_len/M*2+2)=dif_encoder(D,ugc_mpsk);
                branch1=X(1,:);
                branch2=X(2,:);
                len_x=size(branch1,2);
                
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  channel model     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                snr_per_tx=SNR(snr_id)/2;
                H=crandn(1,2);
                Noise=crandn(1,len_x);
                
                Y=sqrt(snr_per_tx)*H*X+Noise;
                
                sig_pow=snr_per_tx*norm(H)^2;
                
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    demodulation     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                b_hat=diff_dec(Y,M);
                
                for k=1:length(b_hat)
                    if (b_hat(k) ~= b(k,frame)) 
                        count_error = count_error+1;
                    end
                end
                frame=frame+1;
            end % for frame
            ber_snr(round)=count_error/nr_bits;
            count_error=0;
        end%for round
        ber(snr_id)=sum(ber_snr)/100;
        
        
    end%for snr
    ber_mod(:,id)=ber(:);
    
    %     if(M==1)
    %         semilogy(SNR_dB,ber,'r-s')
    %     elseif(M==3)
    %         semilogy(SNR_dB,ber,'-s') 
    %     else
    %         semilogy(SNR_dB,ber,'bla-s')
    %     end
    % xlabel('SNR(dB)')
    % ylabel('BER')
    
end

semilogy(SNR_dB,ber_mod(:,1),'r-s',SNR_dB,ber_mod(:,2),'-s',SNR_dB,ber_mod(:,3),'bla-s')
xlabel('SNR(dB)')
ylabel('BER')
title('Differential Space-time Modulation')
grid on