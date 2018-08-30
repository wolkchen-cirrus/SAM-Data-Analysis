% despike_phasespace3d( fi, i_plot, i_opt );
function [fo, ip] = despike_phasespace3d( fi, i_opt )
%======================================================================
%
% Version 1.2
%
% This subroutine excludes spike noise from Acoustic Doppler 
% Velocimetry (ADV) data using phase-space method, using 
% modified Goring and Nikora (2002) method by Nobuhito Mori (2005).
% Further modified by Joseph Ulanowski to remove offset in output (2014).
% Note that iterative use is needed to remove both large and small spikes.
%
% Requires: func_excludeoutlier_ellipsoid3d.m
% 
%======================================================================
%
% Input
%   fi     : input data with dimension (n,1)
%   i_plot : =9 plot results (optional)
%   i_opt : = 0 or not specified  ; return spike noise as NaN
%           = 1            ; remove spike noise and variable becomes shorter than input length
%           = 2            ; interpolate NaN using cubic polynomial
%
% Output
%   fo     : output (filtered) data
%   ip     : excluded array element number in fi
%
% Example: 
%   [fo, ip] = despike_phasespace3d( fi, 9 );
%     or
%   [fo, ip] = despike_phasespace3d( fi, 9, 2 );
%
%
%======================================================================
% Terms:
%
%       Distributed under the terms of the terms of the BSD License
%
% Copyright:
%
%       Nobuhito Mori
%           Disaster Prevention Research Institue
%           Kyoto University
%           mori@oceanwave.jp
%
%========================================================================
%
% Update:
%       1.2     2014/03/18 Offset removed for non-zero mean data [J.U.]
%       1.11    2009/06/09 Interpolation has been added.
%       1.01    2009/06/09 Minor bug fixed
%       1.00    2005/01/12 Nobuhito Mori
%
%========================================================================

% maximum iterations
n_iter = 20;
n_out  = 999;

f_mean = 0;     % do not calculate f_mean here, as it will be affected by spikes (was: f_mean = nanmean(fi);)
f      = fi;    % this offset subtraction is unnecessary now (was: f = fi - f_mean;)

n_loop = 1;

while (n_out~=0) && (n_loop <= n_iter)
    % step 0
    f_mean=f_mean+nanmean(f); % accumulate offset value at each step [J.U.]
    f = f - nanmean(f);
    
    % step 1: first and second derivatives
    f_t  = gradient(f);
    f_tt = gradient(f_t);
    
    % step 2: estimate angle between f and f_tt axis
    if n_loop==1
        theta = atan2( sum(f.*f_tt), sum(f.^2) );
    end
    
    % step 3: checking outlier in the 3D phase space
    [~,~,~,ip,~] = func_excludeoutlier_ellipsoid3d(f,f_t,f_tt,theta);
    
    %
    % --- excluding data
    %
    
    n_nan_1 = size(find(isnan(f)==1),1);
    f(ip)  = NaN;
    n_nan_2 = size(find(isnan(f)==1),1);
    n_out   = n_nan_2 - n_nan_1;
    
    %
    % --- end of loop
    %
    
    n_loop = n_loop + 1;
    
end

go = f + f_mean;    % add offset back
ip = find(isnan(go));

%
% --- interpolation or shorten NaN data
%

if abs(i_opt) >= 1
	% remove NaN from data
    inan = ~isnan(go);
    fo = go(inan);
    % interpolate NaN data
    if abs(i_opt) == 2
        x   = find(~isnan(go));
        y   = go(x);
        xi  = 1:max(length(fi));
        fo = interp1(x, y, xi, 'PCHIP')';
    end
else
    % output despiked value as NaN
    fo = go;
end

end
