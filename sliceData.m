function [ slices ] = sliceData( profilestruct, altitudes, pindex, counts )
%sliceData - Returns drone data at pre-defined altitudes

profs = fieldnames(profilestruct);
[rp,~] = size(profs);
[~,ca] = size(altitudes);
index = zeros(ca,rp);
for i=1:rp
    [rpf,~] = size(profilestruct.(['profile_',num2str(i)]));
    for j=1:ca
        diffbuff = zeros(rpf,1);
        for k=1:rpf
            diffbuff(k) = abs(altitudes(j)- ... 
                profilestruct.(['profile_',num2str(i)])(k).altitude);
        end
        index(j,i) = find(min(diffbuff)==diffbuff);
    end
end
index = sort(index,1);
vars = fieldnames(profilestruct.profile_1);
[rv,~] = size(vars);
valbuf = zeros(ca,rv);
for i=1:rp
    for j=1:ca
        for k=1:rv
            valbuf(j,k) = profilestruct. ... 
                (['profile_',num2str(i)])(index(j,i)).(vars{k});
        end
    end
    mvalstore.(['profile_',num2str(i)]) = valbuf;
end
pindex(1) = [];
pindex(end) = [];
[ri,~] = size(pindex);
for i=1:ri
    index(:,i+1) = index(:,i+1)+pindex(i);
end
[~,cc] = size(counts);
valbuf = zeros(ca,cc);
for i=1:rp
    for j=1:ca
        for k=1:cc
            valbuf(j,k) = counts(index(j,i),k);
        end
    end
    uvalstore.(['profile_',num2str(i)]) = valbuf;
end
for i=1:rp
    valstore.(['profile_',num2str(i)]) =  ... 
        [mvalstore.(['profile_',num2str(i)]), ... 
        uvalstore.(['profile_',num2str(i)])];
end

slices = valstore;
end

