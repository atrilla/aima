----------------------------------------------------------------------
-- File    : uniform_cost_search.lua
-- Created : 12-Feb-2015
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

-- Uniform-cost search algorithm.
--
-- PRE:
-- problem - cost-weighted adjacency matrix (table).
-- start - starting node index (number).
-- finish - finishing node index (number).
-- treegraph - tree/graph version flag (boolean).
--   True for graph search version.
--
-- POST:
-- solution - solution path (table). State set to zero if failure.


require("best_first_search")

local function eval_path(cost)
  return cost[1]
end

function uniform_cost_search(problem, start, finish, treegraph)
  -- heuristic is not taken into account
  zeros = {}
  for i = 1, #problem do
    zeros[i] = 0
  end
  return best_first_search(problem, start, finish, treegraph,
    eval_path, zeros)
end

