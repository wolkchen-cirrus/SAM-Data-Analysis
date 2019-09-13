function [ TEMP_LUT, HUM_LUT ] = genMETLUT( LUT_MET, Tres, Hres )
%genMETLUT - Genarate meteorological look up table
%   Heavily based on calMET, generates a high resolution look-up table for
%   use in the AeroSAM pi zero based data logger. LUT_MET is the
%   calibration data, and res is the desired output resolution.

LUT = csvread(LUT_MET);
[tx, ti] = unique(LUT(:,3));
TEMP_fit = fit(tx,LUT(ti,1),'linearinterp');
c = true;
i = 1;
while c == true
    if LUT(i,4) == 0
        LUT(i,:) = [];
        i = i-1;
    end
    [rl,~] = size(LUT);
    i = i+1;
    if i>rl
        c = false;
    end
end
HUM_fit = scatteredInterpolant([LUT(:,3),LUT(:,4)],LUT(:,2),'linear' ...
    ,'linear');

end

