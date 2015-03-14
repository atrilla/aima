----------------------------------------------------------------------
-- File    : trt_amp.lua
-- Created : 12-Mar-2015
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


package.path = package.path .. ";../src/?.lua;../data/?.lua"

require("genetic_algorithm")

print("TRT amp")
print("-------")

local rval = {10,12,15,18,22,27,33,39,47,56,68,82}
local population = {}
for i = 1, 500 do
  local indiv = {}
  local r
  for j = 1, 28 do
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

local function checkvals(a, start)
  local rcount = 0
  for i = 1, 4 do
    rcount = rcount + a[start - 1 + i] * math.pow(2, 4 - i)
  end
  if (rcount > 12) then return {-1} end
  if (rcount == 0) then return {-1} end
  local ecount = 0
  for i = 1, 3 do
    ecount = ecount + a[start + 3 + i] * math.pow(2, 3 - i)
  end
  if (ecount > 5) then return {-1} end
  if (ecount == 0) then return {-1} end
  return {rcount, ecount}
end

local function calcR (r)
  return rval[r[1]] * math.pow(10, r[2] - 1)
end

local function fitness(x)
  -- calc all R vals, discard if one is outa range (return -20)
  local vcc = 20
  local R1 = checkvals(x, 1)
  if (R1[1] == -1) then return 0 end
  local R2 = checkvals(x, 8)
  if (R2[1] == -1) then return 0 end
  local Rc = checkvals(x, 15)
  if (Rc[1] == -1) then return 0 end
  local Re = checkvals(x, 22)
  if (Re[1] == -1) then return 0 end
  -- define vo func
  local function vo(vi)
    return vcc - (calcR(Rc) / calcR(Re)) * (vcc * calcR(R2) / 
      (calcR(R1) + calcR(R2)) + vi - 0.7)
  end
  -- calc fitness, return
  local err_sym = (vcc/2 - vo(0))^2
  local err_min = (0 - vo(1))^2
  local err_max = (vcc - vo(-1))^2
  local err_clip_pos = (vcc*0.8 - vo(-0.8))^2
  local err_clip_neg = (vcc*0.2 - vo(0.8))^2
  return -math.log(err_sym + err_min + err_max + err_clip_pos +
    err_clip_neg)
end

local t1 = os.clock()
local solution = genetic_algorithm(population, fitness)
local t2 = os.clock()

local R1 = checkvals(solution, 1)
local R2 = checkvals(solution, 8)
local Rc = checkvals(solution, 15)
local Re = checkvals(solution, 22)
 
print("Solution is state...")
print("R1: ", calcR(R1))
print("R2: ", calcR(R2))
print("Rc: ", calcR(Rc))
print("Re: ", calcR(Re))

print("Elapsed: " .. t2 - t1)

print("")

