----------------------------------------------------------------------
-- File    : orgate.lua
-- Created : 01-May-2015
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

-- OR gate built with ANN.

package.path = package.path .. ";../src/?.lua;../data/?.lua"

require "neural_network"

local net = ann:new(2,4,1)
local data = {{0,0},{0,1},{1,0},{1,1}}
local t = {{0},{1},{1},{1}}

net:train(data,t)

print("0 0 -> ", net:predict({0,0})[1])
print("0 1 -> ", net:predict({0,1})[1])
print("1 0 -> ", net:predict({1,0})[1])
print("1 1 -> ", net:predict({1,1})[1])


