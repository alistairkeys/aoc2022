import std/[sequtils, sets, tables, enumerate]

# https://adventofcode.com/2022/day/3

proc score(what: char): int =
  if what in {'a'..'z'}: what.ord - 'a'.ord + 1
  else: what.ord - 'A'.ord + 27

proc part1(filename: string): int =
  for l in filename.lines:
    let parts = distribute(toSeq(l), 2)
    var misplaced = parts[0].toHashSet * parts[1].toHashSet
    inc result, score(misplaced.pop)

proc part2(filename: string): int =
  var cnt: CountTable[char]
  for idx, l in enumerate filename.lines:
    for ch in deduplicate(toSeq(l)): cnt.inc ch
    if idx mod 3 == 2:
      inc result, score(cnt.largest.key)
      cnt.reset

when isMainModule:
  doAssert part1("../data/day03_example.txt") == 157
  echo part1("../data/day03_input.txt")

  doAssert part2("../data/day03_example.txt") == 70
  echo part2("../data/day03_input.txt")
