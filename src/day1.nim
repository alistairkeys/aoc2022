import std/[algorithm, strutils, math]

# https://adventofcode.com/2022/day/1

proc getCalories(filename: string): seq[int] =
  var accum: int
  for l in filename.lines:
    if l.len > 0:
      accum += parseInt l
    else:
      result.add accum
      accum = 0

  # Handle the last line if required
  if accum > 0:
    result.add accum

proc part1(filename: string): int =
  max getCalories(filename)

proc part2(filename: string): int =
  getCalories(filename)
    .sorted(SortOrder.Descending)
    .toOpenArray(0, 2)
    .sum

when isMainModule:
  doAssert part1("../data/day01_example.txt") == 24000
  echo part1("../data/day01_input.txt")

  doAssert part2("../data/day01_example.txt") == 45000
  echo part2("../data/day01_input.txt")
