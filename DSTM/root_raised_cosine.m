function pulse_shape = root_raised_cosine(Q, alpha, len)

T = 1*Q;
t = -len*Q:1:len*Q;
pulse_shape = 4 * alpha * ...
            ( cos((1+alpha)*pi*t/T) + (1-alpha)*pi/(4*alpha) * sinc((1-alpha)*t/T) ) ./ ...
            (pi*sqrt(T)*(1-16*alpha^2*t.^2/T^2));



