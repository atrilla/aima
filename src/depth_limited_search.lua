----------------------------------------------------------------------
-- File    : depth_limited_search.lua
-- Created : 14-Feb-2015
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

-- Recursive implementation of the depth-limited tree search 
-- algorithm.
--
-- PRE:
-- problem - cost-weighted adjacency matrix (table).
-- start - starting node index (number).
-- finish - finishing node index (number).
-- limit - depth limit (number).
--
-- POST:
-- solution - solution path (table). State set to zero if standard
--   failure (no solution). Minus one if cutoff failure (no solution
--   within the depth limit).


local function recursive_dls(node, problem, finish, limit)
  local solution = {}
  if (node.state == finish) then
    return node
  elseif (limit == 0) then
    solution.state = -1
    return solution
  else
    local cutoff = false
    for i = 1, #problem do
      if (problem[node.state][i] > 0) then
        if (i ~= node.state) then
          -- expand search space
          local child = {state = i}
          local path = {}
          for j = 1, #node.parent do
            table.insert(path, node.parent[j])
          end
          table.insert(path, node.state)
          child.parent = path
          child.cost = node.cost + problem[node.state][i]
          local result = recursive_dls(child, problem, finish,
            limit - 1)
          if (result.state == -1) then
            cutoff = true
          elseif (result.state ~= 0) then
            return result
          end
        end
      end
    end
    if (cutoff) then
      solution.state = -1
    else
      solution.state = 0
    end
    return solution
  end
end

function depth_limited_search(problem, start, finish, limit)
  -- inits
  local node = {}
  node.state = start
  node.parent = {}
  node.cost = 0
  return recursive_dls(node, problem, finish, limit)
end

