function [ MET_data,TEMP_fit,HUM_fit ] = calMET( date, LUT_MET, log_file )

path = [date, '\', 'LOGGER', '\', log_file];
raw = dlmread(path,',',7,0);
[~,cr] = size(raw);
if cr>3
    raw(:,4:end) = [];
end
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
HUM_fit = scatteredInterpolant([LUT(:,3),LUT(:,4)],LUT(:,2),'linear','linear');
[rr,cr] = size(raw);
METout = zeros(rr,cr);
METout(:,1) = raw(:,1);
for i=1:rr
    METout(i,2) = TEMP_fit(raw(i,2));
    METout(i,3) = HUM_fit(raw(i,2),raw(i,3));
    if METout(i,3)>100
        METout(i,3) = 100;
    end
end

MET_data = METout;
end

