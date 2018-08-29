function [mass_conc] = UCASSmass_conc(rawcounts,bbs,metstruct,density)

%   Density in ug/m^3
counts = rawcounts(:,2:15);
[~,cbb] = size(bbs);
centers = zeros(1,cbb-1);
for i=1:cbb-1
    centers(1,i) = mean([bbs(1,i),bbs(1,i+1)]);
end
[rc,cc] = size(counts);
volbuf = zeros(rc,cc);
for i=1:rc
    for j=1:cc
        volbuf(i,j) = counts(i,j)*((centers(1,j)/(2*1000000))^3)*4/3*pi;
    end
end
massbuf = volbuf*density;
Vz = abs([metstruct.velocity]);
Asample = 0.5e-6;
mconc_buf = zeros(rc,1);
for i=1:rc
    mconc_buf(i,1) = sum(massbuf(i,:))*Vz(i)*Asample;
end

mass_conc = mconc_buf;
end

