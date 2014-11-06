function signal_space(Ich,Qch,power_h)
%plot the signal space of demodulated data
%done!
hold on

len_data=length(Ich);
correct_sig_x=[-3,-3,-3,-3,-1,-1,-1,-1,1,1,1,1,3,3,3,3];
correct_sig_y=[-3,-1,1,3,-3,-1,1,3,-3,-1,1,3,-3,-1,1,3];

x=Ich*sqrt(10);% because the symbol is normalized
y=Qch*sqrt(10);

axis([-6 6 -6 6])

plot(x/power_h,y/power_h,'.')
plot(correct_sig_x,correct_sig_y,'r+')
title('Signal Space')
grid on
drawnow
