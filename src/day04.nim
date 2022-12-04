import std/[strscans, sugar]

# https://adventofcode.com/2022/day/4

proc countOverlaps(filename: string,
                   overlaps: proc(a1, b1, a2, b2: int): bool): int =
  for l in filename.lines:
    var a1, b1, a2, b2: int
    discard scanf(l, "$i-$i,$i-$i", a1, b1, a2, b2)
    if overlaps(a1, b1, a2, b2): inc result

proc part1(filename: string): int =
  countOverlaps(filename,
    (a1, b1, a2, b2) => (a1 <= a2 and b1 >= b2) or (a2 <= a1 and b2 >= b1))

proc part2(filename: string): int =
  countOverlaps(filename,
    (a1, b1, a2, b2) => min(b1, b2) - max(a1, a2) >= 0)

when isMainModule:
  doAssert part1("../data/day04_example.txt") == 2
  echo part1("../data/day04_input.txt")

  doAssert part2("../data/day04_example.txt") == 4
  echo part2("../data/day04_input.txt")
