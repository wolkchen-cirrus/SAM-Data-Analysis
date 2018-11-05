function [ metrt, pixrt ] = RTCzero( log_file, pix_file, date )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

logPath = [date,'/','LOGGER','/',log_file];
pixPath = [date,'/','PIXHAWK','/',pix_file];
load(pixPath);
GPSms = GPS(:,4);

dbuf = strsplit(date,'-');
dbuf = {dbuf{2},dbuf{3},dbuf{1}};
amdate = strjoin(dbuf,'-');
day = weekday(amdate);
msOffset = 86400000*(day-1);
GPSms = GPSms-msOffset;

sheet = strsplit(log_file,'.');
sheet = sheet{1};
t = xlsread(logPath,sheet,'B1');
LOGms = 86400000*t-3600000;
METms = dlmread(logPath,',',7,0);
METms = METms(:,1)+LOGms;

metrt = METms;
pixrt = GPSms;
end

