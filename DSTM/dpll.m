function [delta_f]=dpll(in_I,in_Q,training)
% clear all;
% close all;
% 
% K0 = pi/2;
% f_offset = 0.0157;
% ph_offset = pi/7; 
% 
% filter_order = 20;
% lpf = fir1(filter_order, .7);
% %%% 
% data_len = 900;
% in_seq = zeros(1, data_len);
% out_seq = zeros(1, data_len);
% for k = 1:data_len
%     in_seqI(k) = (-1)^k*cos(f_offset*k + ph_offset);
%     in_seqQ(k) = (-1)^k*sin(f_offset*k + ph_offset);
% end
data_len=length(training);
in_seqI=in_I(1:data_len);
in_seqQ=in_Q(1:data_len);

theta = 0.001;

alpha = .8;
loop_gain  = .15;
loop_filter_output = 0;
% c1=0.2;
% c2=.3;


Ich = zeros(1, data_len);
Qch = zeros(1, data_len);

for k = 1:data_len
    out_seq(k) = loop_filter_output;
%%% 
    Ich(k) = training(k)*cos(theta)*in_seqQ(k);
    Qch(k) = training(k)*sin(theta)*in_seqI(k);
    phase_diff = Ich(k)-Qch(k);
    
% %%% Loop Filter
    loop_filter_output = loop_filter_output*alpha + (1-alpha)*phase_diff

    loop_filter_output = loop_filter_output*loop_gain;
    
%      loop_filter_output=loop_filter_output+c2*phase_diff(2)+(c1-c2)*phase_diff(1);
%      phase_diff(1)=phase_diff(2);

%%%% NCO
%     if(training(k)~=training(k+1))
%         K0=
    theta = theta+loop_filter_output;
    if (theta>2*pi) 
        theta = theta - 2*pi;
    else
        if (theta<0) 
            theta = theta + 2*pi;
        end
    end
end
plot(out_seq)
delta_f=mean(out_seq(data_len-70:data_len))