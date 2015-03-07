----------------------------------------------------------------------
-- File    : genetic_algorithm.lua
-- Created : 05-Mar-2015
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

-- Genetic algorithm.
--
-- PRE:
-- population - set of individuals (table).
-- fitness - evaluate individual (function).
--
-- POST:
-- solution - solution state (table).
--
-- Each individual (state) is a binary array.
-- Population is ordered from best to worst according to fitness. It
-- must be greater than one.
-- Fitness is normalised from 0 (bad) to 1 (good).


local function sort_population(population, fitness)
  local function comp(x, y)
    return (fitness(x) < fitness(y))
  end
  return table.sort(population, comp)
end

local function random_selection(population, fitness)
  local fit = {}
  local sumfit = 0
  for i = 1, #population do
    local fitIndi = fitness(population[i])
    table.insert(fit, fitIndi)
    sumfit = sumfit + fitIndi
  end
  fit[1] = fit[1] / sumfit
  for i = 2, #fit do
    fit[i] = fit[i] / sumfit + fit[i-1]
  end
  local x, y
  local rx = math.random()
  local ry = math.random()
  for i = 1, #fit do
    if (rx < fit[i]) then
      x = population[i]
      break
    end
  end
  for i = 1, #fit do
    if (ry < fit[i]) then
      y = population[i]
      break
    end
  end
  return x, y
end

local function reproduce(x, y)
  local point = math.floor(math.random() * #x) + 1
  local child = {}
  for i = 1, point do
    child[i] = x[i]
  end
  for i = point + 1, #x do
    child[i] = y[i]
  end
  return child
end

local function mutate(x)
  for i = 1, #x do
    if (math.random() < 0.1) then
      x[i] = math.abs(x[i] - 1)
    end
  end
end

function genetic_algorithm(population, fitness)
  local solution
  for epoch = 1, 100 do
    sort_population(population, fitness)
    local new_population = {}
    for i = 1, #population do
      local x, y = random_selection(population, fitness)
      local child = reproduce(x, y)
      if (math.random() < 0.05) then
        mutate(child)
      end
      table.insert(new_population, child)
    end
    population = new_population
  end
  return population[1]
end

