----------------------------------------------------------------------
-- File    : best_first_search.lua
-- Created : 12-Feb-2015
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

-- Best-first search algorithm.
--
-- PRE:
-- problem - cost-weighted adjacency matrix (table).
-- start - starting node index (number).
-- finish - finishing node index (number).
-- treegraph - tree/graph version flag (boolean).
--   True for graph search version.
-- feval - evaluation function.
-- heuristic - must be a heuristic at the node level (table).
--
-- POST:
-- solution - solution path (table). State set to zero if failure.
--
-- In this implementation, cost is a vector: 
-- {path_cost, heuristic_cost}.


function best_first_search(problem, start, finish, treegraph, feval,
  heuristic)
  -- inits
  local node = {}
  node.state = start
  node.parent = {}
  node.cost = {0, heuristic[start]}
  local solution = {}
  --
  if (node.state == finish) then
    solution = node
  else
    local frontier = {node}
    local explored = {}
    local found = false
    while (not found) do
      if (#frontier == 0) then
        solution.state = 0
        found = true
        break
      end
      -- pop frontier, lowest cost node
      testNode = frontier[1]
      testIdx = 1
      for i = 2, #frontier do
        if (feval(frontier[i].cost) < feval(testNode.cost)) then
          testNode = frontier[i]
          testIdx = i
        end
      end
      table.remove(frontier, testIdx)
      node = testNode
      -- check
      if (node.state == finish) then
        solution = node
        break
      end
      -- explore
      if (treegraph) then
        table.insert(explored, node.state)
      end
      for i = 1, #problem do
        if (problem[node.state][i] > 0) then
          if (i ~= node.state) then
            local child = {state = i}
            local path = {}
            for j = 1, #node.parent do
              table.insert(path, node.parent[j])
            end
            table.insert(path, node.state)
            child.parent = path
            child.cost = {node.cost[1] + problem[node.state][i],
              heuristic[i]}
            -- by default, continue exploration
            local notExpl = true
            if (treegraph) then
              for j = 1, #explored do
                if (explored[j] == i) then
                  notExpl = false
                  break
                end
              end
            end
            if (notExpl) then
              inFront = false
              for j = 1, #frontier do
                if (frontier[j].state == i) then
                  inFront = true
                  if (feval(frontier[j].cost) > feval(child.cost))
                  then
                    frontier[j] = child
                  end
                  break
                end
              end
              if (not inFront) then
                table.insert(frontier, child)
              end
            end
          end
        end
      end
    end
  end
  return solution
end

