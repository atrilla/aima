----------------------------------------------------------------------
-- File    : unit_breadth_first_search.lua
-- Created : 11-Feb-2015
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

-- Unit test for the breadth-first search algorithm.


package.path = package.path .. ";../src/?.lua;../data/?.lua"

local germany = require("germany")
require("breadth_first_search")

t1 = os.clock()
solution = breadth_first_search(germany.problem, 
  germany.state.Frankfurt, germany.state.Stuttgart, true)
t2 = os.clock()

print("Stuttgart ID is " .. germany.state.Stuttgart)
print(solution.state)
print("cost " .. solution.cost)
for i = 1,#solution.parent do
  print("Parent " .. solution.parent[i])
end
print("Elapsed " .. t2 - t1)

