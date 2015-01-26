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
## @deftypefn {Function File} {@var{solution} =} iterative_deepening_search(@var{problem}, @var{start}, @var{finish})
## Iterative deepening search algorithm.
##
## PRE:
## @var{problem} must be the cost-weighted adjacency matrix.
## @var{start} must be the starting node index.
## @var{finish} must be the finishing node index.
##
## POST:
## @var{solution} is the solution path. State set to zero if there
## is no solution.
## @end deftypefn

## Author: Alexandre Trilla <alex@atrilla.net>

function [solution] = iterative_deepening_search(problem, start, ...
  finish)

  limit = 1;
  while (limit)
    solution = depth_limited_search(problem, start, finish, limit);
    limit += 1;
    if (solution.state ~= 1)
      break;
    endif
  endwhile

endfunction

% Test based on BFS article on Wikipedia: 
% http://en.wikipedia.org/wiki/Breadth-first_search

%!test
%! load ../data/germany.dat;
%! S = iterative_deepening_search(G, D.Frankfurt, D.Stuttgart);
%! assert(S.state == D.Stuttgart);

