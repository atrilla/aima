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
## @deftypefn {Function File} {@var{solution} =} recursive_dls(@var{node}, @var{problem}, @var{finish}, @var{limit})
## Recursive implementation of depth-limited tree search.
##
## PRE:
## @var{node} must be the starting node.
## @var{problem} must be the cost-weighted adjacency matrix.
## @var{finish} must be the finishing node index.
## @var{limit} must be the depth limit.
##
## POST:
## @var{solution} is the solution path. State set to zero if standard
## failure (no solution). One if cutoff failure (no solution within 
## the depth limit).
## @end deftypefn

## Author: Alexandre Trilla <alex@atrilla.net>

function [solution] = recursive_dls(node, problem, finish, limit)

  if (node.state == finish)
    solution = node;
  elseif (limit == 0)
    solution.state = 1;
  else
    cutoff = 0;
    for i = 1:size(problem, 2)
      if (problem(node.state, i)>0)
        if (i ~= node.state)
          % expand search space
          child.state = i;
          path = node.parent;
          path = [path node.state];
          child.parent = path;
          child.cost = node.cost + problem(node.state, i);
          result = recursive_dls(child, problem, finish, ...
            limit - 1);
          if (result.state == 1)
            cutoff = 1;
          elseif (result.state ~= 0)
            solution = result;
            return;
          endif
        endif
      endif
    endfor
    if (cutoff)
      solution.state = 1;
    else
      solution.state = 0;
    endif
  endif

endfunction

