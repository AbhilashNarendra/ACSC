function  [syn_start_1] = sync(mat1, training1, training2, L, nxt_frame_pos_1)

% t_samp = sync(mf, b_train, Q, t_start, t_end)
%
% Determines when to sample the matched filter outputs. The synchronization
% algorithm is based on cross-correlating a replica of the (known)
% transmitted training sequence with the output from the matched filter
% (before sampling). Different starting points in the matched filter output
% are tried and the shift yielding the largest value of the absolute value
% of the cross-correlation is chosen as the sampling instant for the first
% symbol.
%
% Input:
%   mat1,mat2            = matched filter output, complex baseband, I+jQ
%   training1,2          = the training sequence bits
%   L                    = number of samples per symbol
%   nxt_frame_pos_1,2    = start of search window
%
% Output:
%   syn_start_1,2 = sampling instant for first symbol

syn=1;
len_train=length(training1);

for k=nxt_frame_pos_1:10+nxt_frame_pos_1
    tr_m=mat1(k:L:k+L*len_train-1);
    sigma_1_1(syn)=dot(training1,tr_m); %the training sequence is training_len bits
    sigma_2_1(syn)=dot(training2,tr_m);           
    syn=syn+1;
end                  

syn=1;


sigma_I1_1=real(sigma_1_1);
sigma_Q1_1=imag(sigma_1_1);
sigma_I2_1=real(sigma_2_1);
sigma_Q2_1=imag(sigma_2_1);



sigma_tot_1=sigma_I1_1.^2+sigma_Q1_1.^2+sigma_I2_1.^2+sigma_Q2_1.^2;

[max_value_1,syn_start_1]=max(sigma_tot_1);
syn_start_1=nxt_frame_pos_1+syn_start_1-1;

