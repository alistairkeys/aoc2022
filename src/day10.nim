import std/[sequtils, strutils]

# https://adventofcode.com/2022/day/10

proc part1(filename: string): int =
  var
    reg = 1
    pending = 0
    idx = 0
    cycles = 1

  let l = filename.lines.toSeq

  while idx < l.len:
    let op = l[idx].split(" ")

    if (cycles + 20) mod 40 == 0:
      inc result, cycles * reg
    inc cycles

    if op.len == 1:
      inc idx
    elif pending != 0:
      inc reg, pending
      inc idx
      pending = 0
    else:
      pending = op[1].parseInt

when isMainModule:
  doAssert part1("../data/day10_example.txt") == 13140
  echo part1("../data/day10_input.txt")
