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
## @deftypefn {Function File} {@var{solution} =} a_star_search (@var{problem}, @var{start}, @var{finish}, @var{treegraph}, @var{heuristic})
## A-star search algorithm.
##
## PRE:
## @var{problem} must be the cost-weighted adjacency matrix.
## @var{start} must be the starting node index.
## @var{finish} must be the finishing node index.
## @var{treegraph} must be the tree/graph version flag. 0 is tree-version.
## @var{heuristic} must be the heuristic vector.
##
## POST:
## @var{solution} is the solution path. State set to zero if failure.
## @end deftypefn

## Author: Alexandre Trilla <alex@atrilla.net>

function [solution] = a_star_search(problem, start, finish, treegraph,
  heuristic)

  % eval func is anonymous and returns path cost
  % doing this, heuristic is compounded in the node cost
  solution = best_first_search(problem, start, finish, treegraph, ...
    @(p,h) p + h, heuristic);

endfunction

% Test based on BFS article on Wikipedia: 
% http://en.wikipedia.org/wiki/Breadth-first_search

%!test
%! load ../data/germany.dat;
%! S = a_star_search(G, D.Frankfurt, D.Munchen, 1, [378 341 265 216 282 379 150 63 0 458]);
%! assert(S.state == D.Munchen);

