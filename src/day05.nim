import std/[deques, sequtils, strscans, strutils, algorithm]

# https://adventofcode.com/2022/day/5

proc moveStuff(filename: string, allowMultipleMove: bool): string =
  var
    parsingBlocks = true
    stacks: seq[Deque[char]]

  for l in filename.lines:
    if stacks.len == 0: # first line, allocate stacks
      for i in 0 ..< (l.len + 1) div 4:
        stacks.add Deque[char]()

    if l.len == 0: # end of blocks/indices, start of moves
      parsingBlocks = false
    elif parsingBlocks:
      if l[1] in Digits: continue # column indices
      var strIdx = 1
      var stackIdx = 0
      while strIdx < l.len:
        if l[strIdx] != ' ':
          stacks[stackIdx].addFirst l[strIdx] # lowest idx = top of stack
        inc strIdx, 4
        inc stackIdx
    else:
      var moves, fromPos, toPos: int
      discard scanf(l, "move $i from $i to $i", moves, fromPos, toPos)

      var addMe: seq[char]
      for cnt in 1..moves:
        addMe.add stacks[fromPos - 1].popLast

      if allowMultipleMove: addMe.reverse
      for el in addMe:
        stacks[toPos - 1].addLast(el)

  result = $stacks.mapIt(it.peekLast()).join

proc part1(filename: string): string = moveStuff(filename, false)
proc part2(filename: string): string = moveStuff(filename, true)

when isMainModule:
  doAssert part1("../data/day05_example.txt") == "CMZ"
  echo part1("../data/day05_input.txt")

  doAssert part2("../data/day05_example.txt") == "MCD"
  echo part2("../data/day05_input.txt")
