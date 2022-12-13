import std/[sequtils, strutils, algorithm]

# https://adventofcode.com/2022/day/11

type
  Monkey = ref object
    worryLevels: seq[int]
    count: int
    op: seq[string]
    divisor: int
    passToNext: proc(x: int): int
    next: array[bool, int]

proc part1(filename: string): int =

  var monkeys: seq[Monkey]

  for l in filename.lines:
    var l = l.strip
    if l.startsWith "Monkey ":
      monkeys.add Monkey()
    elif l.startsWith "Starting items: ":
      monkeys[^1].worryLevels.add l.split("Starting items: ")[1].split(
          ", ").mapIt(it.parseInt)
    elif l.startsWith "Operation: new = old ":
      monkeys[^1].op = l.split("Operation: new = old ")[1].split(" ")
    elif l.startsWith "Test: divisible by ":
      monkeys[^1].divisor = l.split("Test: divisible by ")[1].parseInt
    elif l.startsWith "If true: ":
      monkeys[^1].next[true] = ($l[^1]).parseInt
    elif l.startsWith "If false: ":
      monkeys[^1].next[false] = ($l[^1]).parseInt

  for rounds in 0 ..< 20:
    for monkeyIdx, m in monkeys.mpairs:
      m.worryLevels.reverse
      while m.worryLevels.len > 0:
        inc m.count
        var w = m.worryLevels.pop
        if m.op[0] == "+":
          if m.op[1] == "old":
            w *= 2
          else:
            w += m.op[1].parseInt
        else:
          if m.op[1] == "old":
            w *= w
          else:
            w *= m.op[1].parseInt
        w = w div 3
        monkeys[m.next[w mod m.divisor == 0]].worryLevels.add w

  let counts = monkeys.mapIt(it.count).sorted(SortOrder.DESCENDING)
  result = counts[0] * counts[1]

when isMainModule:
  doAssert part1("../data/day11_example.txt") == 10605
  echo part1("../data/day11_input.txt")

