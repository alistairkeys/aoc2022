import std/sugar

# https://adventofcode.com/2022/day/2

func score(letter: char): int =
  case letter
    of 'A', 'X': 0
    of 'B', 'Y': 1
    of 'C', 'Z': 2
    else: raise newException(ValueError, "Unexpected input type")

proc rockPaperScissors(filename: string, scoreMe: proc(theirInput,
    myInput: int): int): int =
  for l in filename.lines:
    let theirInput = score(l[0])
    let myInput = score(l[2])
    inc result, scoreMe(theirInput, myInput)

proc part1(filename: string): int =
  rockPaperScissors(filename, (theirInput, myInput) => (
    if myInput == theirInput: myInput + 4
    elif myInput == ((theirInput + 1) mod 3): myInput + 7
    else: myInput + 1
  ))

proc part2(filename: string): int =
  rockPaperScissors(filename, (theirInput, myInput) => (
    case myInput
    of 0: ((theirInput + 2) mod 3) + 1 # lose
    of 1: theirInput + 4 # draw
    else: ((theirInput + 1) mod 3) + 7 # win
  ))

when isMainModule:
  doAssert part1("../data/day02_example.txt") == 15
  echo part1("../data/day02_input.txt")

  doAssert part2("../data/day02_example.txt") == 12
  echo part2("../data/day02_input.txt")
