----------------------------------------------------------------------
-- File    : op_amp.lua
-- Created : 17-Mar-2015
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

-- Component optimisation for an AC common-emitter amplifier with 
-- emitter degeneration. Obj: max symmetrix excursion without
-- clipping.


package.path = package.path .. ";../../src/?.lua;../../data/?.lua"

require("genetic_algorithm")

print("OP amp")
print("------")

local r = {10,12,15,18,22,27,33,39,47,56,68,82}
local exp = {1, 10, 100, 1000, 10000}
local rval = {}
for i = 1, #exp do
  for j = 1, #r do
    table.insert(rval, r[j] * exp[i])
  end
end
local population = {}
math.randomseed(os.time())
for i = 1, 100 do
  local indiv = {}
  local r
  for j = 1, 12 do
    r = math.random()
    if (r < 0.5) then
      r = 0
    else
      r = 1
    end
    table.insert(indiv, r)
  end
  table.insert(population, indiv)
end

local function checkval(a, start)
  local rcount = 0
  for i = 1, 6 do
    rcount = rcount + a[start - 1 + i] * math.pow(2, 6 - i)
  end
  if (rcount > 60) then return -1 end
  if (rcount == 0) then return -1 end
  return rval[rcount]
end

-- define vo func
local function vo(vi, Rf, Rg)
  return vi * (1 + Rf/Rg)
end

local function esmfit(Rf, Rg)
  local esmval = (20 - (vo(1, Rf, Rg) - vo(-1, Rf, Rg)))^2
  return 1/esmval
end

local function fitness(x)
  local vcc = 15 
  local Rf = checkval(x, 1)
  if (Rf == -1) then return 0 end
  local Rg = checkval(x, 7)
  if (Rg == -1) then return 0 end
  -- calc fitness, return
  return esmfit(Rf, Rg)
end

-- exhaustive linear search
local t1 = os.clock()
eRf = rval[1]
eRg = rval[1]
efit = esmfit(eRf, eRg)
for rf = 1, #rval do
  for rg = 1, #rval do
    local fit = esmfit(rval[rf], rval[rg])
    if (fit > efit) then
      eRf = rval[rf]
      eRg = rval[rg]
      efit = fit
    end
  end
end
local t2 = os.clock()
print("Exhaustive solution is state...")
print("Rf: ", eRf)
print("Rg: ", eRg)
print("Fitness: ", efit)
print("Elapsed: " .. t2 - t1)

print("")

t1 = os.clock()
local solution = genetic_algorithm(population, fitness)
t2 = os.clock()

local Rf = checkval(solution, 1)
local Rg = checkval(solution, 7)
 
print("GA solution is state...")
print("Rf: ", Rf)
print("Rg: ", Rg)
print("Fitness: ", fitness(solution))

print("Elapsed: " .. t2 - t1)

print("")

