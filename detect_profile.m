function [ profiles, index] = detect_profile( metstruct )

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



