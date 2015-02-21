----------------------------------------------------------------------
-- File    : unit_beyond_classical_search.lua
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

-- Unit test for chapter 4


package.path = package.path .. ";../src/?.lua;../data/?.lua"

local hills = require("hills")
require("hill_climbing")

print("Unit test chapter 4")
print("")

print("Hill climbing")
print("-------------")
local t1 = os.clock()
local solution = hill_climbing(hills, 10)
local t2 = os.clock()

print("Starting on 10, solution is state...", solution)

print("Elapsed: " .. t2 - t1)

solution = hill_climbing(hills, 2)
print("Starting on 2, solution is state...", solution)
solution = hill_climbing(hills, 20)
print("Starting on 20, solution is state...", solution)

print("")

