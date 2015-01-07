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
## @deftypefn {Function File} {@var{solution} =} depth_limited_search (@var{problem}, @var{start}, @var{finish}, @var{limit})
## Recursive implementation of depth-limited tree search.
##
## PRE:
## @var{problem} must be the cost-weighted adjacency matrix.
## @var{start} must be the starting node index.
## @var{finish} must be the finishing node index.
## @var{limit} must be the depth limit.
##
## POST:
## @var{solution} is the solution path. Zero if standard failure
## (no solution). One if cutoff failure (no solution within the
## depth limit).
## @end deftypefn

## Author: Alexandre Trilla <alex@atrilla.net>

function [solution] = depth_limited_search(problem, start, ...
    finish, limit)

node.state = start;
node.parent = [];
node.cost = 0;
solution = recursive_dls(node, problem, finish, limit);

endfunction

% Test based on BFS article on Wikipedia: 
% http://en.wikipedia.org/wiki/Breadth-first_search

%!test
%! load ../data/germany.dat;
%! S = depth_limited_search(G, D.Frankfurt, D.Stuttgart, 10);
%! assert(S.state == D.Stuttgart);

