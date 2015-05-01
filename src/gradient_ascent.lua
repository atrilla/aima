----------------------------------------------------------------------
-- File    : gradient_ascent.lua
-- Created : 03-Apr-2015
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

-- Gradient ascent algorithm.
--
-- PRE:
-- objfun - objective funciton to maximise (funciton).
-- var - variables, starting point vector (table).
-- step - step size (number).
--
-- POST:
-- Updates var with the max of objfun.
--
-- Loop while evaluation increases.


function gradient_ascent(objfun, var, step)
  local epsilon = 1e-4
  local feval = objfun(var)
  local grad = {}
  for i = 1, #var do
    table.insert(grad, 0)
  end
  local newvar = {}
  for i = 1, #var do
    table.insert(newvar, 0)
  end
  while (true) do
    local preveval = feval
    -- calc grad
    for i = 1, #var do
      local value = var[i]
      var[i] = value + epsilon 
      local right = objfun(var)
      var[i] = value - epsilon 
      local left = objfun(var)
      var[i] = value
      grad[i] = (right - left) / (2 * epsilon)
    end
    -- new var
    for i = 1, #var do
      newvar[i] = var[i] + step * grad[i]
    end
    -- eval
    feval = objfun(newvar)
    print(feval)
    if ((feval - preveval) > 1e-6) then
      -- update var
      for i = 1, #var do
        var[i] = newvar[i]
      end
    else
      break
    end
  end
end

