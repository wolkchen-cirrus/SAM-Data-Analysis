function [ filename ] = genfile( generic )

list = dir;
[rl, ~] = size(list);
namebuf = [generic,'_00.csv'];
namecell = cell(1,rl);
for i=1:rl
    namecell{i} = list(i).name;
end
for i=1:rl
    namebuf(1,end-5) = num2str(floor(i/10));
    namebuf(1,end-4) = num2str(rem(i,10));
    if ~any(strcmp(namecell,namebuf))
        filename = namebuf;
        break
    end
end

end

