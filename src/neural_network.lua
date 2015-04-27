----------------------------------------------------------------------
-- File    : neural_network.lua
-- Created : 26-Apr-2015
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

-- Artificial neural network class (multilayer perceptron model).
--
-- Activation function is assumed to be sigmoid.
-- Tikhonov regularisation is set to 1.


ann = {}


-- PRE:
-- IN - size of input layer (number).
-- HID - size of hidden layer (number).
-- OUT - size of output layer (number).
--
-- POST:
-- Returns an instance of an ANN (table).

function ann:new(IN, HID, OUT)
  local newann = {Lin = IN, Lhid = HID, Lout = OUT}
  self.__index = self
  setmetatable(newann, self)
  newann:initw()
  return newann
end


-- POST:
-- Initialises the model (the thetas).

function ann:initw()
  local epsilonIN = math.sqrt(6) / math.sqrt(self.Lin + self.Lhid)
  local epsilonOUT = math.sqrt(6) / math.sqrt(self.Lhid + self.Lout)
  --
  local function initmat(din, dout, value)
    local mat = {}
    for i = 1, dout do
      local aux = {}
      for j = 1, din do
        table.insert(aux, ((math.random() - 0.5) / 0.5 ) * value)
      end
      table.insert(mat, aux)
    end
    return mat
  end
  --
  self.thetain = initmat(self.Lin + 1, self.Lhid, epsilonIN)
  self.thetaout = initmat(self.Lhid + 1, self.Lout, epsilonOUT)
end


-- PRE:
-- input - column [N,1] vector (table).
--
-- POST:
-- Returns output [K,1] vector (table).

function ann:predict(input)
  local function matprod(m1, m2)
    local result = {}
    -- init
    for i = 1, #m1 do
      local row = {}
      for j = 1, #m2[1] do
        table.insert(row, 0)
      end
      table.insert(result, row)
    end
    -- multiply
    for i = 1, #m1 do
      for j = 1, #m2[1] do
        local prod = 0
        for k = 1, #m1[1] do
          prod = prod + m1[i][k] * m2[k][j]
        end
        result[i][j] = prod
      end
    end
    return result
  end
  --
  local function sigmoid(x)
    local y = 1 / (1 + math.exp(-x))
    return y
  end
  -- step 1
  local aIN = {{1}}
  for i = 1, #input do
    table.insert(aIN, {input[i][1]})
  end
  -- step 2
  local zHID = matprod(self.thetain, aIN)
  local aHID = {{1}}
  for i = 1, #zHID do
    table.insert(aHID, {sigmoid(zHID[i][1])})
  end
  -- step 3
  local azOUT = matprod(self.thetaout, aHID)
  for i = 1, #azOUT do
    azOUT[i][1] = sigmoid(azOUT[i][1])
  end
  return azOUT
end

