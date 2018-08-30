function [ Dout ] = run_filter( Din, type, quality, maxitts )
%run_filter - A function to filter data using various methods
%   Din must be in the form of [n,1], quality is a quality threshold, type
%   is filter type, and maxitts is the maximum number of itterations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   type:                       quaility:           maxitts
%   0       No filtering        N/A                 N/A
%   1       phase-space filter  stopping criterion  maximum itterations
%   2       1-D digital filter  window size         N/A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if type == 0
    Dout = Din;
elseif type == 1
    c = true;
    i = 2;
    j = 0;
    r = zeros(1,maxitts);
    while c == true
        j = j+1;
        [Din, ip] = despike_phasespace3d(Din,2);
        [ri,~] = size(ip);
        r(j) = ri;
        if r(i) == r(i-1)
            i = i+1;
        end
        if (i > quality)||(j > maxitts)
            c = false;
        end
    end
    Dout = Din;
elseif type == 2
    b = (1/quality)*ones(1,quality);
    a = 1;
    Dout = filter(b,a,Din);
end

end

