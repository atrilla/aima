## Copyright (C) 2014 Alexandre Trilla
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
## @deftypefn {Function File} {@var{solution} =} breadth_first_search (@var{problem}, @var{start}, @var{finish})
## Breadth-first search algorithm on a graph (uninformed strategy).
##
## PRE:
## @var{problem} must be the cost-weighted adjacency matrix.
## @var{start} must be the starting node index.
## @var{finish} must be the finishing node index.
##
## POST:
## @var{solution} is the solution path. Zero if failure.
## @end deftypefn

## Author: Alexandre Trilla <alex@atrilla.net>

function [solution] = breadth_first_search(problem, start, finish)

% inits
node.state = start;
node.parent = [];
node.cost = 0;

if node.state == finish
    solution = node;
else
    frontier = [node];
    explored = [];
    found = 0;
    while(~found)
        if numel(frontier) == 0
            solution = 0;
            found = 1;
            break;
        end
        % pop frontier
        node = frontier(1);
        frontier = frontier(2:end);
        % explore
        explored(numel(explored)+1) = node.state;
        for i=1:size(problem, 2)
            if problem(node.state, i)>0
                if i~=node.state
                    if ~sum(explored == i)
                        inFront = 0;
                        for j=1:numel(frontier)
                            if frontier(j).state == i
                                inFront = 1;
                                break;
                            end
                        end
                        if ~inFront
                            % expand search space
                            child.state = i;
                            path = node.parent;
                            path = [path node.state];
                            child.parent = path;
                            child.cost = node.cost + ...
                                problem(node.state, i);
                            % check goal
                            if i==finish
                                solution = child;
                                found = 1;
                                break;
                            else
                                frontier = [frontier child];
                            end
                        end
                    end
                end
            end
        end
    end
end

endfunction

% Test based on BFS article on Wikipedia: 
% http://en.wikipedia.org/wiki/Breadth-first_search

%!test
%! load ../data/germany.dat;
%! S = breadth_first_search(G, D.Frankfurt, D.Stuttgart);
%! assert(S.state == D.Stuttgart);
%! assert(S.parent(1) == D.Frankfurt);
%! assert(S.parent(2) == D.Wurzburg);
%! assert(S.parent(3) == D.Nurnberg);

