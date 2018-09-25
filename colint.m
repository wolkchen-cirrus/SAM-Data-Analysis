function [ intParams ] = colint( profiles )
%colint - Column Integrates the profile struct
%   profiles is the profile struct, this is integrated numerically with
%   respect to altitude. The integrated function is returned.

excluded = {'temperature';'humidity';'time';'velocity'};
profs = fieldnames(profiles);
[re,~] = size(excluded);
[rp,~] = size(profs);
vars = fieldnames(profiles.profile_1);
[rv,~] = size(vars);
rv = rv-re-1;
for i=1:rp
    [~,r] = size([profiles.(['profile_',num2str(i)]).altitude]);
    intvars = zeros(r-1,rv);
    for k=1:re
        profiles.(['profile_',num2str(i)]) = ...
            rmfield(profiles.(['profile_',num2str(i)]),(excluded{k}));
    end
    altitude = [profiles.(['profile_',num2str(i)]).altitude]';
    profiles.(['profile_',num2str(i)]) = ...
        rmfield(profiles.(['profile_',num2str(i)]),'altitude');
    vars = fieldnames(profiles.(['profile_',num2str(i)]));
    for j=1:rv
        for k=1:r-1
            amb = profiles.(['profile_',num2str(i)])(k).(vars{j}) - ...
                profiles.(['profile_',num2str(i)])(k+1).(vars{j});
            h = altitude(k)-altitude(k+1);
            intvars(k,j) = amb/2*h;
        end
    end
    intvars = cumsum(intvars,1);
    altitude(end) = [];
    valstore.(['profile_',num2str(i)]) = [altitude,intvars];
end

intParams = valstore;
end

