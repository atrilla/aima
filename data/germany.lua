-- Data based on the breadth-first search article on Wikipedia
-- http://en.wikipedia.org/wiki/Breadth-first_search

local _problem = {{0, 85, 217, 0, 0, 0, 0, 0, 0, 173},
  {85, 0, 0, 0, 80, 0, 0, 0, 0, 0},
  {217, 0, 0, 0, 0, 186, 103, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 183, 0, 0, 0},
  {0, 80, 0, 0, 0, 0, 0, 250, 0, 0},
  {0, 0, 186, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 103, 183, 0, 0, 0, 0, 167, 0},
  {0, 0, 0, 0, 250, 0, 0, 0, 84, 0},
  {0, 0, 0, 0, 0, 0, 167, 84, 0, 502},
  {173, 0, 0, 0, 0, 0, 0, 0, 502, 0}}

local _state = {Frankfurt = 1,
  Mannheim = 2,
  Wurzburg = 3,
  Stuttgart = 4,
  Karlsruhe = 5,
  Erfurt = 6,
  Nurnberg = 7,
  Ausburg = 8,
  Munchen = 9,
  Kassel = 10}

return {problem = _problem, state = _state}

