----------------------------------------------------------------------
-- File    : greedy_search.lua
-- Created : 16-Feb-2015
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

-- Greedy search algorithm.
--
-- PRE:
-- problem - must be the cost-weighted adjacency matrix (table).
-- start - must be the starting node index (number).
-- finish - must be the finishing node index (number).
-- treegraph - must be the tree/graph version flag (boolean).
--   True for graph search version.
-- heuristic - heuristic vector (table).
--
-- POST:
-- solution - is the solution path. State set to zero if failure.


require("best_first_search")

local function eval_heuristic(cost)
  return cost[2]
end

function greedy_search(problem, start, finish, treegraph, heuristic)
  -- eval func returns heuristic only
  return best_first_search(problem, start, finish, treegraph,
    eval_heuristic, heuristic)
end

