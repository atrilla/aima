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
## @deftypefn {Function File} {@var{solution} =} best_first_search (@var{problem}, @var{start}, @var{finish}, @var{treegraph}, @var{feval}, @var{heuristic})
## Best-first search algorithm.
##
## PRE:
## @var{problem} must be the cost-weighted adjacency matrix.
## @var{start} must be the starting node index.
## @var{finish} must be the finishing node index.
## @var{treegraph} must be the tree/graph version flag. 0 is tree-version.
## @var{feval} must be a handle to the evaluation function.
## @var{heuristic} must be a heuristic at the node level.
##
## POST:
## @var{solution} is the solution path. State set to zero if failure.
##
## In this implementation, cost is a vector: [path_cost heuristic_cost].
## @end deftypefn

## Author: Alexandre Trilla <alex@atrilla.net>

function [solution] = best_first_search(problem, start, finish, ...
  treegraph, feval, heuristic)

  % inits
  node.state = start;
  node.parent = [];
  node.cost = [0 heuristic(start)];
  
  if (node.state == finish)
    solution = node;
  else
    frontier = [node];
    explored = [];
    found = 0;
    while (~found)
      if (numel(frontier) == 0)
        solution.state = 0;
        found = 1;
        break;
      endif
      % pop frontier, lowest cost node
      testNode = frontier(1);
      testIdx = 1;
      for i = 2:numel(frontier)
        if (feval(frontier(i).cost) < feval(testNode.cost))
          testNode = frontier(i);
          testIdx = i;
        endif
      endfor
      frontier = ...
        frontier([1:(testIdx-1) (testIdx+1):numel(frontier)]);
      node = testNode;
      % check
      if (node.state == finish)
        solution = node;
        break;
      endif
      % explore
      if (treegraph)
        explored(numel(explored)+1) = node.state;
      endif
      for i = 1:size(problem, 2)
        if (problem(node.state, i)>0)
          if (i ~= node.state)
            child.state = i;
            child.parent = [node.parent node.state];
            accumPath = node.cost(1) + problem(node.state, i);
            child.cost(1) = accumPath;
            child.cost(2) = heuristic(i);
            notExpl = 1;
            if (treegraph)
              notExpl = ~sum(explored == i);
            endif
            if (notExpl)
              inFront = 0;
              for j = 1:numel(frontier)
                if (frontier(j).state == i)
                  inFront = 1;
                  if (feval(frontier(j).cost) > feval(child.cost))
                    frontier(j) = child;
                  endif
                  break;
                endif
              endfor
              if (~inFront)
                frontier = [frontier child];
              endif
            endif
          endif
        endif
      endfor
    endwhile
  endif

endfunction

