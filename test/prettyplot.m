## Copyright (C) 2014-2015 Alexandre Trilla
##
## This file is part of AIMA.
##
## AIMA is free software: you can redistribute it and/or modify it
## under the terms of the MIT/X11 License as published by the
## Massachusetts Institute of Technology. See the MIT/X11 License
## for more details.
##
## You should have received a copy of the MIT/X11 License along with
## this source code distribution of AIMA (see the COPYING file in the
## root directory). If not, see
## <http://www.opensource.org/licenses/mit-license>.

## -*- texinfo -*-
## @deftypefn {Utility Function} {} ut_prettyplot (@var{h})
## Embellish the given plot for publication purposes.
##
## PRE:
## @var{h} must be a handle to the given plot.
##
## POST:
## Plot is enhanced with appropriate size and font.
## @end deftypefn

## Author: Alexandre Trilla <alex@atrilla.net>

function [] = prettyplot(h)

W = 3;
H = 2;
set(h,'PaperUnits','inches')
set(h,'PaperOrientation','portrait');
set(h,'PaperSize',[H,W])
set(h,'PaperPosition',[0,0,W,H])

FN = findall(h,'-property','FontName');
set(FN,'FontName','/usr/share/fonts/truetype/droid/DroidSans.ttf');
FS = findall(h,'-property','FontSize');
set(FS,'FontSize',8);

print('whatever.eps', '-depsc', '-S450,300')

endfunction

