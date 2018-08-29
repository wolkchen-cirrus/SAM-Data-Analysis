function [ mstruct ] = metstruct( rawmet )

[rr,cr] = size(rawmet);
met_struct = struct('time',cell(rr,1),'temperature',cell(rr,1),...
    'humidity',cell(rr,1),'altitude',cell(rr,1),'velocity',cell(rr,1),...
    'particle_mass_conc',cell(rr,1));
for i=1:rr
    met_struct(i).time = rawmet(i,1);
    met_struct(i).temperature = rawmet(i,2);
    met_struct(i).humidity = rawmet(i,3);
    met_struct(i).altitude = rawmet(i,4);
    met_struct(i).velocity = rawmet(i,5);
    if cr>5
        met_struct(i).particle_mass_conc = rawmet(i,6);
    end
end

mstruct = met_struct;
end

