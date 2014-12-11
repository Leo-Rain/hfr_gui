function Tt = t_predic_totals( t, LonLat, ts, nodal, varargin )
% T_PREDIC_TOTALS  t_predic tidal predictions that generates a TUV structure
%
% This functions uses the T_tide toolbox of R. Pawlowicz et al.
% (http://www2.ocgy.ubc.ca/~rich/#T_Tide) to predict tides.  It assumes that
% tidal analysis was performed on the complex data U+i*V, probably using
% t_tide_totals.
% 
% NOTE: t_predic must be on the path for this function to work.
%
% Usage: Ttide = t_predic_totals(TIM,LonLat,TIDESTRUC,nodal,prop,val...)
%
% Inputs
% ------
% TIM = a vector of times in datenum format for making predictions
% LonLat = Lon,Lat coordinates of the totals grid points
% TIDESTRUC = an array of tide structures for making predictions.
%             Generally generated by t_tide_totals.  Should have the same
%             number of elements as coordinate pairs in LonLat.
% nodal = boolean indicating whether nodal corrections were used in
%         t_tide_totals. 
% property,value,... = parameter name,value pairs for t_predic_matrix.  See
%                      that function for details. These may override
%                      prop,val pairs generated by this function (e.g.,
%                      'latitude' if nodal is true).
%
% Outputs
% -------
% Ttide = TUV structure with predicted tides. NOTE: This function
%         generates a rather basic TUV structure.  Extra metadata must be
%         filled in by hand later.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 	$Id: t_predic_totals.m 396 2007-04-02 16:56:29Z mcook $	
%
% Copyright (C) 2007 David M. Kaplan
% Licence: GPL
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if exist( 't_tide' ) < 2
  error( [ mfilename ' - Generic t_tide function must be on path.' ] );
end

t = t(:)';

if ~exist( 'nodal', 'var' ), nodal = true; end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial arguments to t_tide
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varg = {};
if nodal
  % Latitude must be a cell array for t_tide_matrix
  lt = LonLat(:,2)';
  lt = num2cell( lt );
  
  varg = { 'latitude', lt };
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tide prediction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xx = t_predic_matrix( t, ts, varg{:}, varargin{:} )';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate TUV structure and fill
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tt = TUVstruct( size(xx), 0 );

Tt.ProcessingSteps{end+1} = mfilename;
Tt.OtherMetadata.(mfilename).nodal = nodal;
Tt.OtherMetadata.(mfilename).varargin = varargin;
Tt.OtherMetadata.(mfilename).Type = 'tide';
  
Tt.U = real( xx );
Tt.V = imag( xx );
  
Tt.LonLat = LonLat;
Tt.TimeStamp = t;

