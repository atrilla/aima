----------------------------------------------------------------------
-- File    : adt_search.lua
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

-- Abstract data type search algorithm.
--
-- PRE:
-- problem - cost-weighted adjacency matrix (table).
-- start - starting node index (number).
-- finish - finishing node index (number).
-- treegraph - tree/graph version flag (boolean).
--   True for graph search version.
-- insert - function to manage the insertion into the frontier.
--
-- POST:
-- solution - solution path (table). State set to zero if failure.
--
-- It is convenient to state the problem as an adjacency matrix
-- because state references must be directly accessed.


function adt_search(problem, start, finish, treegraph, insert)
  -- inits
  local node = {}
  node.state = start
  node.parent = {}
  node.cost = 0
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
      -- pop frontier
      node = frontier[1]
      table.remove(frontier, 1)
      -- explore
      if (treegraph) then
        table.insert(explored, node.state)
      end
      for i = 1, #problem do
        if (problem[node.state][i] > 0) then
          if (i ~= node.state) then
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
                  break
                end
              end
              if (not inFront) then
                -- expand search space
                local child = {state = i}
                local path = {}
		for j = 1, #node.parent do
		  table.insert(path, node.parent[j])
		end
		table.insert(path, node.state)
                child.parent = path
                child.cost = node.cost + problem[node.state][i]
                -- check goal
                if (i == finish) then
                  solution = child
                  found = true
                  break
                else
                  insert(frontier, child)
                end
              end
            end
          end
        end
      end
    end
  end
  return solution
end

