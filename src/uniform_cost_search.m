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
## @deftypefn {Function File} {@var{solution} =} uniform_cost_search (@var{problem}, @var{start}, @var{finish}, @var{treegraph})
## Uniform-cost search algorithm.
##
## PRE:
## @var{problem} must be the cost-weighted adjacency matrix.
## @var{start} must be the starting node index.
## @var{finish} must be the finishing node index.
## @var{treegraph} must be the tree/graph version flag. 0 is tree-version.
##
## POST:
## @var{solution} is the solution path. State set to zero if failure.
## @end deftypefn

## Author: Alexandre Trilla <alex@atrilla.net>

function [solution] = uniform_cost_search(problem, start, ...
  finish, treegraph)

  % eval func is anonymous and returns path cost
  solution = best_first_search(problem, start, finish, treegraph, ...
    @(cost) cost(1), zeros(1, size(problem, 2)));

endfunction

% Test based on BFS article on Wikipedia: 
% http://en.wikipedia.org/wiki/Breadth-first_search

%!test
%! load ../data/germany.dat;
%! S = uniform_cost_search(G, D.Frankfurt, D.Munchen, 1);
%! assert(S.state == D.Munchen);
%! assert(S.parent(1) == D.Frankfurt);
%! assert(S.parent(2) == D.Wurzburg);
%! assert(S.parent(3) == D.Nurnberg);

