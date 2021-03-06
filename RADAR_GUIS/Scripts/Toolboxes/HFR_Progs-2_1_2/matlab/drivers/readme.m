% This directory contains driver(s) that automate some of the HF radar
% processing.  They are basically intented as templates that can be used by
% individual users to develop drivers that are tailored to specific needs.
%
% There is currently only a few drivers.  The central one is:
%
% HFRPdriver_Totals_OMA
%
% This driver assumes that you have some radial data at a particular
% timestep, with filenames that are compatible with what is generated by
% datenum_to_directory_filename.  You pass this driver a structure with
% configuration information and it will process those radials to totals
% and do OMA fits and save both in individual files.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 	$Id: README.m 464 2007-07-23 23:42:59Z dmk $	
%
% Copyright (C) 2007 David M. Kaplan
% Licence: GPL (Gnu Public License)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
