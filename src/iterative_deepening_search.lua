----------------------------------------------------------------------
-- File    : iterative_deepening_search.lua
-- Created : 15-Feb-2015
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

-- Iterative-deepening search algorithm.
--
-- PRE:
-- problem - must be the cost-weighted adjacency matrix (table).
-- start - must be the starting node index (number).
-- finish - must be the finishing node index (number).
--
-- POST:
-- solution - is the solution path. State set to zero if failure.


require("depth_limited_search")

function iterative_deepening_search(problem, start, finish)
  local limit = 1
  while (true) do
    local solution = 
      depth_limited_search(problem, start, finish, limit)
    limit = limit + 1
    if (solution.state ~= -1) then
      return solution
    end
  end
end

