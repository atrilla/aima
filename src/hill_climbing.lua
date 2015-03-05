----------------------------------------------------------------------
-- File    : hill_climbing.lua
-- Created : 20-Feb-2015
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

-- Hill climbing algorithm.
--
-- PRE:
-- problem - must be an array of costs, index indicates state (table).
-- start - must be the starting state index (number).
--
-- POST:
-- solution - is the solution state (number).


local function eval_left(problem, current)
  if (problem[current - 1] > problem[current]) then
    return current - 1, true
  else
    return current, false
  end
end

local function eval_right(problem, current)
  if (problem[current + 1] > problem[current]) then
    return current + 1, true
  else
    return current, false
  end
end

function hill_climbing(problem, start)
  local current = start
  local neighbour
  local change
  while (true) do
    if (current == 1) then
      neighbour, change = eval_right(problem, current)
    elseif (current == #problem) then
      neighbour, change = eval_left(problem, current)
    else
      neighbour, change = eval_left(problem, current)
      if (change == false) then
        neighbour, change = eval_right(problem, current)
      end
    end
    if (change) then
      current = neighbour
    else
      return current
    end
  end
end

