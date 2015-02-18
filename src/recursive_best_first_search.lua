----------------------------------------------------------------------
-- File    : recursive_best_first_search.lua
-- Created : 18-Feb-2015
-- By      : Alexandre Trilla <alex@atrilla.net>
--
-- AIMA - Artificial Intelligence, A Maker's Approach
--
-- Copyright (C) 2015 A.I. Maker
----------------------------------------------------------------------
--
-- This file is part of AIMA.
--
-- AIMA is free software: you can redistribute it and/or modify it
-- under the terms of the MIT/X11 License as published by the
-- Massachusetts Institute of Technology. See the MIT/X11 License
-- for more details.
--
-- You should have received a copy of the MIT/X11 License along with
-- this source code distribution of AIMA (see the COPYING file in the
-- root directory). If not, see
-- <http://www.opensource.org/licenses/mit-license>.
----------------------------------------------------------------------

-- Recursive best-first search algorithm.
--
-- PRE:
-- problem - cost-weighted adjacency matrix (table).
-- start - starting node index (number).
-- finish - finishing node index (number).
-- heuristic - must be a heuristic at the node level (table).
--
-- POST:
-- solution - solution path (table). State set to zero if failure.
--
-- In this implementation, cost is a vector: 
-- {path_cost, heuristic_cost}.


function recursive_best_first_search(problem, start, finish,
  heuristic)
  -- inits
  local node = {}
  node.state = start
  node.parent = {}
  node.cost = {0, heuristic[start]}
  return rbfs(problem, node, finish, heuristic, math.huge)
end

function rbfs(problem, node, finish, heuristic, flimit)
  if (node.state == finish) then
    return node
  else
    local successors = {}
    -- for each action in problem given state...
    for i = 1, #problem do
      if (problem[node.state][i] > 0) then
        if (i ~= node.state) then
          local child = {state = i}
          local path = {}
          for j = 1, #node.parent do
            table.insert(path, node.parent[j])
          end
          table.insert(path, node.state)
          child.parent = path
          child.cost = {node.cost[1] + problem[node.state][i],
            heuristic[i]}
          table.insert(successors, child)
        end
      end
    end
    if (#successors == 0) then
      return {state = 0}
    end
    while (true) do
      -- 1st and 2nd lowest fval in successors
      local best = successors[1]
      local alternative = best
      if (#successors > 1) then
        alternative = successors[2]
        if ((best.cost[1] + best.cost[2]) >
          (alternative.cost[1] + alternative.cost[2])) then
          best, alternative = alternative, best
        end
        for i = 3, #successors do
          -- check best
          if ((successors[i].cost[1] + successors[i].cost[2]) <
            (best.cost[1] + best.cost[2])) then
            alternative = best
            best = successors[i]
          elseif ((successors[i].cost[1] + successors[i].cost[2]) <
            (alternative.cost[1] + alternative.cost[2])) then
            alternative = successors[i]
          end
        end
      end
      local bestf = best.cost[1] + best.cost[2]
      local alternativef = alternative.cost[1] + alternative.cost[2]
      local result
      if (bestf < flimit) then
        result = rbfs(problem, best, finish, heuristic,
          math.min(flimit, alternativef))
      else
        node.cost[1] = best.cost[1]
        node.cost[2] = best.cost[2]
        return {state = 0}
      end
      if (result.state ~= 0) then
        return result
      end
    end
  end
end

