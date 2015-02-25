----------------------------------------------------------------------
-- File    : simulated_annealing.lua
-- Created : 25-Feb-2015
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

-- Simulated annealing algorithm.
--
-- PRE:
-- problem - array of costs, index indicates state (table).
-- start - starting state index (number).
-- schedule - mapping from time to temperature (function).
--   It must end with zero.
--
-- POST:
-- solution - solution state (number).


function simulated_annealing(problem, start, schedule)
  local current = start
  local t = 0
  while (true) do
    t = t + 1
    local T = schedule(t)
    if (T == 0) then return current end
    local move = math.random()
    local successor = current
    if (move < 0.5) then
      if (current > 1) then
        successor = current - 1
      end
    else
      if (current < #problem) then
        successor = current + 1
      end
    end
    local delta = problem[successor] - problem[current]
    if (delta > 0) then
      current = successor
    else
      if (math.random() < math.exp(delta / T)) then
        current = successor
      end
    end
  end
end

