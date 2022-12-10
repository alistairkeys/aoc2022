import std/sets

# https://adventofcode.com/2022/day/9

type
  vec2i = tuple[x, y: int]

var head, tail: vec2i
var covered: HashSet[vec2i]

proc L(delta: int) =
  for i in 0 ..< delta:
    dec head[0]
    if head[0] < tail[0] - 1:
      tail = (head[0] + 1, head[1])
    covered.incl tail

proc R(delta: int) =
  for i in 0 ..< delta:
    inc head[0]
    if head[0] > tail[0] + 1:
      tail = (head[0] - 1, head[1])
    covered.incl tail

proc U(delta: int) =
  for i in 0 ..< delta:
    dec head[1]
    if head[1] < tail[1] - 1:
      tail = (head[0], head[1] + 1)
    covered.incl tail

proc D(delta: int) =
  for i in 0 ..< delta:
    inc head[1]
    if head[1] > tail[1] + 1:
      tail = (head[0], head[1] - 1)
    covered.incl tail

proc resetAll() =
  head.reset
  tail.reset
  covered.reset

when isMainModule:

  block part1_example:
    resetAll()
    include "../data/day09_example.txt"
    doAssert covered.card == 13

  block part1_solution:
    resetAll()
    include "../data/day09_input.txt"
    echo covered.card
