close, clear, clc

date = '18-08-22';
log_file = 'DATA05.CSV';
LUT_MET = 'MET_LUT.csv';
pix_file = '2018-08-22 11-30-26.bin-101613.mat';
LUT_UCASS = 'LUT_D_water.txt';
density = 997000000;

PIXdat = PIXextract(date,pix_file);
[time_met,tfit,hfit] = calMET(date,LUT_MET,log_file);
alt = time2alt(time_met,PIXdat);
met = [time_met,alt];
for i=1:500
    [met(:,2), ip] = despike_phasespace3d(met(:,2),0,2);
end
metdat = metstruct(met);

[ bb, counts ] = calUCASS( date, LUT_UCASS, log_file );
counts = [counts,alt];
mass_conc = UCASSmass_conc(counts,bb,metdat,density);
met = [met,mass_conc];
metdat = metstruct(met);

[profiles,pindex] = detect_profile(metdat);

genfile('SAM_DATA',log_file,pix_file,date,profiles);

plot([profiles.profile_1.temperature],[profiles.profile_1.altitude])
hold on
plot([profiles.profile_2.temperature],[profiles.profile_2.altitude])
hold on
% xlim([0,7])
% hold on
% plot([profiles.profile_3.temperature],[profiles.profile_3.altitude])
% hold on
% plot([profiles.profile_4.temperature],[profiles.profile_4.altitude])


