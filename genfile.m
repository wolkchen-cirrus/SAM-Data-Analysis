function [] = genfile( generic_name, log_file, pix_file, date, profile_struct )

list = dir;
[rl, ~] = size(list);
namebuf = [generic_name,'_00.xls'];
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
nprof = length(fieldnames(profile_struct));
filename = [date,'\',filename];
for i=1:nprof
    writetable(struct2table(profile_struct.(['profile_',num2str(i)])),...
        filename,'sheet',i)
end
xlswrite(filename,{'MET_DATA_FILE'},(nprof+1),'A1')
xlswrite(filename,{'PIXHAWK_DATA_FILE'},(nprof+1),'A2')
xlswrite(filename,{log_file},(nprof+1),'B1')
xlswrite(filename,{pix_file},(nprof+1),'B2')

end

