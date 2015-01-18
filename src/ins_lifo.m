## Copyright (C) 2015 Alexandre Trilla
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
## @deftypefn {Function File} {@var{insertion} =} ins_fifo(@var{frontier}, @var{node})
## Stack insertion.
##
## PRE:
## @var{frontier} must be a struct array for the frontier.
## @var{node} must be a struct for the node.
##
## POST:
## @var{insertion} is the extended frontier.
## @end deftypefn

## Author: Alexandre Trilla <alex@atrilla.net>

function [insertion] = ins_lifo(frontier, node)

  insertion = [node frontier];

endfunction

