function [ Dout ] = time2alt( METcal, PIXdat )

[rmet,~] = size(METcal);
[rpix,~] = size(PIXdat);
databuf = zeros(rmet,2);
tdif = zeros(rpix,1);
METcal(:,1) = METcal(:,1)-METcal(1,1);
for i=1:rmet
    for j=1:rpix
        tdif(j) = abs(METcal(i,1)-PIXdat(j,1)/1000);
    end
    [~,mint] = min(tdif);
    databuf(i,:) = PIXdat(mint,[2,3]);
end

Dout = databuf;
end

