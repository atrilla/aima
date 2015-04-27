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
require("simulated_annealing")
require("genetic_algorithm")
require("gradient_ascent")

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

print("Simulated annealing")
print("-------------------")
local t1 = os.clock()
local function schedule(t)
  if (t > 100) then
    return 0
  else
    return math.exp(-t * 0.08)
  end
end
local solution = simulated_annealing(hills, 10, schedule)
local t2 = os.clock()

print("Starting on 10, solution is state...", solution)

print("Elapsed: " .. t2 - t1)

solution = simulated_annealing(hills, 2, schedule)
print("Starting on 2, solution is state...", solution)
solution = simulated_annealing(hills, 20, schedule)
print("Starting on 20, solution is state...", solution)

print("")

print("Genetic algorithm")
print("-----------------")
population = {{1,1,0,1,1,0}, {1,0,0,0,0,1}, {0,0,0,0,1,1},
  {1,0,1,0,1,0}, {0,0,0,1,0,1}, {1,1,1,0,0,0}}

local function fitness(x)
  local state = 0
  for i = 1, #x do
    state = state + x[i] * math.pow(2, i - 1)
  end
  if (state == 0) then return 0 end
  if (state > 40) then return 0 end
  return hills[state]
end

local t1 = os.clock()
local solution = genetic_algorithm(population, fitness)
local t2 = os.clock()

local statesol = 0
for i = 1, #solution do
  statesol = statesol + solution[i] * math.pow(2, i - 1)
end
print("Solution is state...", statesol)

print("Elapsed: " .. t2 - t1)

print("")

print("Gradient ascent")
print("---------------")

-- Band-pass filter at 1.5kHz

function bpf(f)
  local L = 100e-3
  local C = 10e-6
  local R = 500
  local A = 1 / (1/(2*math.pi*f[1]*L) - 2*math.pi*f[1]*C)
  return math.abs((A/(R^2 + A^2))*math.sqrt(A^2+R^2))
end

local sol = {500}
local t1 = os.clock()
gradient_ascent(bpf, sol, 1)
local t2 = os.clock()

print("Solution is state...", sol[1])

print("Elapsed: " .. t2 - t1)

print("")

