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
met(:,2) = run_filter(met(:,2),2,20,10);

[bb,counts] = calUCASS(date,LUT_UCASS,log_file);
mass_conc = UCASSmass_conc(counts,bb,met(:,5),density);
met = [met,mass_conc];

metdat = metstruct(met);

[profiles,pindex] = detect_profile(metdat);
altitudes = [10,50,70,100,120];
slicestruct = sliceData(profiles,altitudes,pindex,counts);
intParams = colint(profiles);

% genfile('SAM_DATA',log_file,pix_file,date,profiles);

% fig = figure(1);
% ax1 = subplot(1,2,1);
% tln1 = plot([profiles.profile_1.temperature],[profiles.profile_1.altitude],'x');
% hold on
% tln2 = plot([profiles.profile_2.temperature],[profiles.profile_2.altitude],'x');
% hold on
% ylim([10,140])
% xlabel(sprintf('Temperature%cC',char(176)));
% ylabel('Altitude (m)');
% title(['Temperature Profile ',date])
% legend(ax1,{'Ascent','Descent'},'Location','northeast')

% ax2 = subplot(1,2,2);
% mln1 = plot([profiles.profile_1.particle_mass_conc],[profiles.profile_1.altitude]);
% hold on
% mln2 = plot([profiles.profile_2.particle_mass_conc],[profiles.profile_2.altitude]);
% hold on
% ylim([10,140])
% xlabel('Particle Mass Concentration (kgm^-^3)');
% ylabel('Altitude (m)');
% title(['Particle Mass Concentration Profile ',date])
% legend(ax2,{'Ascent','Descent'},'Location','northeast')
% hold off


