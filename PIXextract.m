function [ data ] = PIXextract( date, filename )
%PIXextract - Extracts pixhawk data
%   date is the date the measurements took place (also the folder name),
%   filename is the name of the matlab workspace which pixhawk generates
%   automatically with several pre-defined variables.

path = [date, '\', 'PIXHAWK', '\', filename];
load(path);
databuf = BARO(:,2:3);
databuf(:,1) = databuf(:,1) - databuf(1,1);
[rd,~] = size(databuf);
Vz = GPS(:,13);
[rg,~] = size(Vz);
Vzs = 1:rg;
Vzq = 1:rg/rd:rg;
Vz = interp1(Vzs,Vz,Vzq)';
databuf(end,:) = [];
% databuf(end,:) = [];
databuf = [databuf,Vz];

data = databuf;
end

