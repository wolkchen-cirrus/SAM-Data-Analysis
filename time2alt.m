function [ Dout ] = time2alt( PIXdat, METrt, PIXrt )
%time2alt - turns time domain to altitude domain
%   METcal is the calibrated MET data (array) and PIXdat is the raw pixhawk
%   data, this can also be seen as a function to combine the two data
%   sources.

[rmet,~] = size(METrt);
[rpix,~] = size(PIXdat);
databuf = zeros(rmet,2);
[rg,~] = size(PIXrt);
PRTs = 1:rg;
PRTq = 1:rg/rpix:rg;
PIXrt = interp1(PRTs,PIXrt,PRTq)';
rpix = rpix-1;
tdif = zeros(rpix,1);
for i=1:rmet
    for j=1:rpix
        tdif(j) = abs(METrt(i,1)-PIXrt(j,1));
    end
    [~,mint] = min(tdif);
    databuf(i,:) = PIXdat(mint,[2,3]);
end

Dout = databuf;
end

