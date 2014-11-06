clear all;
close all;

frm_len=900;
frm=40;
SNR_dB=[0:1:4 9  7 13 -5 6 -7 8 9  12 7 10 11 6 0 9 4 15 7 18 16 11 19  6 7 8 9  12 7 10 12 ]; %dB
snr=10.^(SNR_dB./10);
D=[1 -1;1 1];
count_error=0;
nr_bits=frm_len*frm;

bit_source=(rand(1, nr_bits) > .5);
b=reshape(bit_source,[],frm);
id=1;  %  4 different modulations and no modulation.
%adapt_index=randsrc(1,30,[1 2 3])
adapt_order=[1];
nr_round=1;
ins_ber=[0];
ins_snr1=[0];
ins_snr2=[0];
ins_sn1=[0];
ins_sn2=[0];
ins_snr=[];
ber_target=0.01;                  %threshold ber
g1=1.5/63;
g2=1.5/15;
g3=1.5/3;
g4=1.5;
Pb_expected=[];
Pb=0;
for snr_idx=1:length(snr)
    ber_rnd=zeros(1,nr_round);
    
         
        for frame=1:frm % a big loop includes upsampling, pulse shaping, shift to 10KHz....
            b_frame=[b(:,frame)];
            %id=adapt_index(frame);
            %%%%%%%%%%%%%%%%%%%%       modulation         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            count_error=0;
            if(id == 0)  % no modulation
                count_error=0;
                
            elseif(id == 1)
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
            Noise=crandn(2,length(X));
            noise_var=(var(Noise(1,:))+var(Noise(2,:)))/2;

            Y=zeros(2,len_x);
            for i=1:len_x
                Y(:,i)=sqrt(snr_per_tx)*H*X(:,i)+Noise(:,i);
            end   
            
            %  instantaneous SNR...
            ins_sn1=var(Y(1,:))/var(Noise(1,:))/4;
            ins_sn2=var(Y(2,:))/var(Noise(2,:))/4;
            
            ins_snr=(ins_sn1+ins_sn2)/2;%
            
            ins_snr1=[ins_snr1  ins_sn1];
            ins_snr2=[ins_snr2  ins_sn2];
            
         
         
            b_hat=diff_dec_2x2(Y,M);
            
            for k=1:length(b_hat)
                if (b_hat(k) ~= b(k,frame)) 
                    count_error = count_error+1;
                end
            end
            if(id==0)
                count_error=0;
            end
            % Adaptive mod: threasholds: 10e-2 & 10e-3 & 10e-4
                                                        
            
            
             kk=count_error/frm_len;
                                              
                                                 
                   Adapt_order(frame)=id;  
                   ins_ber=[ins_ber kk];
                   
%    Pb_expected=[Pb_expected Pb];
%                    
%        Pb=0.2*exp(-g1*ins_snr);
%        if(Pb<0.01)
%            id=4;
%            continue;
%        end
%        Pb=0.2*exp(-g2*ins_snr);
%        if(Pb<0.01)
%            id=3;
%            continue;
%        end
%        Pb=0.2*exp(-g3*ins_snr);
%        if(Pb<0.01)
%            id=2;
%            continue;
%        end
%        Pb=0.2*exp(-g4*ins_snr);
%        if(Pb<0.01)
%            id=1;
%            continue;
%        else
%            id=0;
%        end
%                    
                   
                   
%           if(kk>0.01)
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
                 
          
                                               if(10*log10(ins_snr)<6) 
%                                                    id=0;
%                                                elseif(10*log10(ins_snr)>0.5&10*log10(ins_snr)<5)
                                                   id=1;
                                               elseif(10*log10(ins_snr)>6&10*log10(ins_snr)<12)
                                                   id=2;
                                               else(10*log10(ins_snr)>12)%0&10*log10(ins_snr)<15)
                                                   id=3;
                                              
                                              end
          
          
                   
                   
                   
                   
         
        end % for frame

         adapt_order=[adapt_order Adapt_order];
        %         figure
        %         plot(id_buff,'-s');
        %         title('changing of Modulation')
        
      
           
    ber(snr_idx)=mean(ber_rnd);
end %for snr

% figure
% semilogy(SNR_dB,ber,'r-s')
% grid on
% title('DSTBC 2x2  (BER vs SNR)');

figure,subplot(211);plot(10*log10((ins_snr1+ins_snr2)/2));
ylabel('ins SNR'); grid on;
% subplot(312); 
% plot(ins_ber); hold on;plot(Pb_expected,'r');grid on;
% ylabel('ins BER');legend('exact BER', 'approximate BER');
% hold off;
subplot(212);
plot(adapt_order);
ylabel('M-PSK ');grid on;
axis([0 1500 0 3]);

% semilogy(SNR_dB,ber_mod(:,1),'r-s',SNR_dB,ber_mod(:,2),'-s',SNR_dB,ber_mod(:,3),'bla-s')
% xlabel('SNR(dB)')
% ylabel('BER')
% title('Differential Space-time Modulation')
% grid on