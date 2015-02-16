----------------------------------------------------------------------
-- File    : unit_problem_solving_searching.lua
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
require("uniform_cost_search")
require("depth_first_search")
require("depth_limited_search")
require("iterative_deepening_search")
require("greedy_search")
require("a_star_search")

print("Breadth-first search")
print("--------------------")
local t1 = os.clock()
local solution = breadth_first_search(germany.problem, 
  germany.state.Frankfurt, germany.state.Munchen, true)
local t2 = os.clock()

print("Solution is Munchen...",
  solution.state == germany.state.Munchen)

print("Path cost is... " .. solution.cost)

print("Parent 1 is Frankfurt...", 
  solution.parent[1] == germany.state.Frankfurt)
print("Parent 2 is Kassel...", 
  solution.parent[2] == germany.state.Kassel)

print("Elapsed: " .. t2 - t1)

print("")

print("Uniform-cost search")
print("-------------------")
t1 = os.clock()
solution = uniform_cost_search(germany.problem, 
  germany.state.Frankfurt, germany.state.Munchen, true)
t2 = os.clock()

print("Solution is Munchen...",
  solution.state == germany.state.Munchen)

print("Path cost is... " .. solution.cost[1])

print("Parent 1 is Frankfurt...", 
  solution.parent[1] == germany.state.Frankfurt)
print("Parent 2 is Wurzburg...", 
  solution.parent[2] == germany.state.Wurzburg)
print("Parent 3 is Nurnberg...", 
  solution.parent[3] == germany.state.Nurnberg)

print("Elapsed: " .. t2 - t1)

print("")

print("Depth-first search")
print("------------------")
t1 = os.clock()
solution = depth_first_search(germany.problem, 
  germany.state.Frankfurt, germany.state.Munchen, true)
t2 = os.clock()

print("Solution is Munchen...",
  solution.state == germany.state.Munchen)

print("Path cost is... " .. solution.cost)

print("Parent 1 is Frankfurt...", 
  solution.parent[1] == germany.state.Frankfurt)

print("Elapsed: " .. t2 - t1)

print("")

print("Depth-limited search")
print("--------------------")
t1 = os.clock()
solution = depth_limited_search(germany.problem, 
  germany.state.Frankfurt, germany.state.Munchen, 3)
t2 = os.clock()

print("Solution is Munchen...",
  solution.state == germany.state.Munchen)

print("Path cost is... " .. solution.cost)

for i = 1, #solution.parent do
  local cName = nil
  for city,id in pairs(germany.state) do
    if (id == solution.parent[i]) then
      print("Parent " .. i .. ": " .. city)
      break
    end
  end
end

print("Elapsed: " .. t2 - t1)

print("")

print("Iterative-deepening search")
print("--------------------------")
t1 = os.clock()
solution = iterative_deepening_search(germany.problem, 
  germany.state.Frankfurt, germany.state.Munchen)
t2 = os.clock()

print("Solution is Munchen...",
  solution.state == germany.state.Munchen)

print("Path cost is... " .. solution.cost)

for i = 1, #solution.parent do
  local cName = nil
  for city,id in pairs(germany.state) do
    if (id == solution.parent[i]) then
      print("Parent " .. i .. ": " .. city)
      break
    end
  end
end

print("Elapsed: " .. t2 - t1)

print("")

print("Greedy search")
print("-------------")
-- heuristic based on highway distances from ViaMichelin
t1 = os.clock()
solution = greedy_search(germany.problem, germany.state.Frankfurt,
  germany.state.Munchen, true, 
  {378, 341, 265, 216, 282, 379, 150, 63, 0, 458})
t2 = os.clock()

print("Solution is Munchen...",
  solution.state == germany.state.Munchen)

print("Path cost is... " .. solution.cost[1])

for i = 1, #solution.parent do
  local cName = nil
  for city,id in pairs(germany.state) do
    if (id == solution.parent[i]) then
      print("Parent " .. i .. ": " .. city)
      break
    end
  end
end

print("Elapsed: " .. t2 - t1)

print("")

print("A-star search")
print("-------------")
-- heuristic based on highway distances from ViaMichelin
t1 = os.clock()
solution = a_star_search(germany.problem, germany.state.Frankfurt,
  germany.state.Munchen, true, 
  {378, 341, 265, 216, 282, 379, 150, 63, 0, 458})
t2 = os.clock()

print("Solution is Munchen...",
  solution.state == germany.state.Munchen)

print("Path cost is... " .. solution.cost[1])

for i = 1, #solution.parent do
  local cName = nil
  for city,id in pairs(germany.state) do
    if (id == solution.parent[i]) then
      print("Parent " .. i .. ": " .. city)
      break
    end
  end
end

print("Elapsed: " .. t2 - t1)

print("")

