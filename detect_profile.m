function [ profiles, index] = detect_profile( metstruct )
%detect_profile - splits data into up and down profiles
%   metstruct is a struct with the following fields: time, temperature,
%   humidity, altitude, and (although not definately) mass concentration.
%   This is genarated by the 'metstruct' function.

[~,pindex] = findpeaks( [metstruct.altitude]','MinPeakProminence',4);
[~,tindex] = findpeaks( -[metstruct.altitude]','MinPeakProminence',4);
[rm,~] = size(metstruct);
[rp,~] = size(pindex);
[rt,~] = size(tindex);
passes = rp+rt+1;
ibuf = [pindex;tindex];
ibuf = sort(ibuf);
ibuf = [1;ibuf];
ibuf = [ibuf;rm];

for i=1:passes
    metbuf.(['profile_',num2str(i)]) = metstruct(ibuf(i):ibuf(i+1));
end

profiles = metbuf;
index = ibuf;
end



