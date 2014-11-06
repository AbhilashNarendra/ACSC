clear all;
close all;

frm_len=1200;
frm=15;
nr_round=1;
SNR_dB=[-2:1:5  4 3 -5 6 7 8 9  12 7 10 11 13 6  9 4 15 7 18 16 11 19 20  ]; %dB
snr=10.^(SNR_dB./10);
D=[1 -1;1 1];
count_error=0;
nr_bits=frm_len*frm;

bit_source=(rand(1, nr_bits) > .5);
b=reshape(bit_source,[],frm);
 
id=1;  %  4 different modulations
%adapt_index=randsrc(1,30,[1 2 3])
adapt_order=[1];
ins_ber=[0];
ins_snr1=[1];
ins_snr2=[1];
ins_snr=[1];
ins_sn1=[1];
kkk=0;
%ber_thre=0.001;                  %threshold ber
for snr_idx=1:length(snr)
    ber_rnd=zeros(1,nr_round);
    for round=1:nr_round
     
        count_error=0;
        for frame=1:frm % a big loop includes upsampling, pulse shaping, shift to 10KHz....
            b_frame=[b(:,frame)];
            %id=adapt_index(frame);
            %%%%%%%%%%%%%%%%%%%%       modulation         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if(id == 0)  % no modulation
                
            elseif(id == 1)
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
            
            H=crandn(2,2);
            Noise=crandn(2,length(X));
            noise_var=(var(Noise(1,:))+var(Noise(2,:)))/2;
%             [W,Lw_1,Lw_2]=water(H,noise_var);
%             [U,S,V] = svd(H);
%             
%             branch1=V(1,1)*W(1,1)*X(1,:)+V(1,2)*W(1,2)*X(2,:);
%             branch2=V(2,1)*W(2,1)*X(1,:)+V(2,2)*W(2,2)*X(2,:);
            
            branch1=X(1,:);
            branch2=X(2,:);
            len_x=size(branch1,2);
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  channel model     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            snr_per_tx=snr(snr_idx)/2;
%             H=crandn(2,2);
%             Noise=crandn(2,len_x);
            Y=zeros(2,len_x);
            for i=1:len_x
                Y(:,i)=sqrt(snr_per_tx)*H*X(:,i)+Noise(:,i);
            end   
            
            %  instantaneous SNR...
            in_snr1=var(Y(1,:))/var(Noise(1,:))/4;
            in_snr2=var(Y(2,:))/var(Noise(2,:))/4;
            
            ins_snr=(ins_snr1+ins_snr2)/2;%
            %ins_snr=sum(ins_snr);
            kkk=kkk+1;
            ins_sn1(kkk)= ins_snr;
            
            
            
            
                        
          %   water filling and power allocation
          % [U,S,V] = svd(H);
%            Lh_1=S(1,1); %diagonal elements of S
%            Lh_2=S(2,2);
       
%        
%             G=U';
%             yy1=G(1,1)*Y(1,:)+G(1,2)*Y(2,:);
%             yy2=G(2,1)*Y(1,:)+G(2,2)*Y(2,:);
%             
%             Y(1,:)=yy1/Lh_1/Lw_1;
%             Y(2,:)=yy2/Lh_2/Lw_2;      
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    demodulation     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             for i=1:len_x
%                 Y(:,i)=ctranspose(H)*Y(:,i);
%             end   
         
            b_hat=diff_dec_2x2(Y,M);
            
            for k=1:length(b_hat)
                if (b_hat(k) ~= b(k,frame)) 
                    count_error = count_error+1;
                end
            end
            
            % Adaptive mod: threasholds: 10e-2 & 10e-3 & 10e-4
                                               if(ins_snr<1.2589) 
                                                   id=0;
                
                                               elseif(ins_snr>1.2589&ins_snr<1.7783)
                                                   id=1;
                                               elseif(ins_snr>1.7783&ins_snr<11.2202)
                                                   id=2;
                                               elseif(ins_snr>11.2202&ins_snr<39.8107)
                                                   id=3;
                                               elseif(ins_snr>39.8107)
                                                   id=4;
                                              end
            
            
%             Pb_64qam=7/4*erfc(sqrt((1/42)*ins_snr))-(49/64)*(erfc(sqrt((1/42)*ins_snr)))^2;
%             
%         if (Pb_64qam<ber_thre)
%           id=4;  
%         else
%             Pb_16qam=2/5*erfc(sqrt(ins_snr/10))*(4-3*erfc(sqrt(ins_snr/10)));
%             if (Pb_16qam<ber_thre)
%                 id=3;
%             else
%                 Pb_qpsk=erfc(sqrt(ins_snr/2)*sin(22.5))%1/2*erfc(sqrt(ins_snr/2));
%                 if(Pb_qpsk<ber_thre)
%                     id=2;
%                 else
%                     id=1;
%                 end
%             end
%         end
            
            
            
%             kk=count_error/frm_len;
%        
%                                                if(kk>=0.1)
%                   ins_ber=[ins_ber kk];
%                                                    id=1;
%                                                elseif(kk<0.1&kk>=0.01)
%                                                    id=2;
%                                                elseif(kk<0.01&kk>=0.004)
%                                                    id=3;
%                                                  else
%                                                    id=4;
%                                               end
                                                 
                   Adapt_order(frame)=id;  
         
        end % for frame
        ber_rnd(round)=count_error/nr_bits;
        
         adapt_order=[adapt_order Adapt_order];
        %         figure
        %         plot(id_buff,'-s');
        %         title('changing of Modulation')
    end% for round
    ber(snr_idx)=mean(ber_rnd);
end %for snr

% figure
% semilogy(SNR_dB,ber,'r-s')
% grid on
% title('DSTBC 2x2  (BER vs SNR)');


figure,subplot(311);semilogy(20*log10(ins_sn1));
ylabel('ins SNR'); 
subplot(312); 
plot(ins_ber);
ylabel('ins BER');
subplot(313);
stem(adapt_order);
title('Adaptive modulation order');
% semilogy(SNR_dB,ber_mod(:,1),'r-s',SNR_dB,ber_mod(:,2),'-s',SNR_dB,ber_mod(:,3),'bla-s')
% xlabel('SNR(dB)')
% ylabel('BER')
% title('Differential Space-time Modulation')
% grid on