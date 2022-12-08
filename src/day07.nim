import std/[strutils, tables]

# https://adventofcode.com/2022/day/7

type
  PathEntry = ref object
    parent: PathEntry
    kids: Table[string, PathEntry]
    size: int64

proc toTheTop(entry: var PathEntry) =
  while entry.parent != nil: entry = entry.parent

proc parse(filename: string): PathEntry =

  result = PathEntry(parent: nil)

  for l in filename.lines:
    if l == "$ cd ..":
      result = result.parent
    elif l == "$ cd /":
      result.toTheTop()
    elif l.startsWith "$ cd":
      let folder = l.split("$ cd ")[1]
      discard result.kids.mgetOrPut(folder, PathEntry(parent: result))
      result = result.kids[folder]
    elif not l.startsWith("$ ls") and not l.startsWith("dir"):
      let file = l.split(" ") # size, name
      if not result.kids.hasKey(file[1]):
        result.kids[file[1]] = PathEntry(parent: result,
            size: int64.high) # so they avoid getting caught in the size calculations later
        var node = result
        while node != nil:
          node.size += parseInt(file[0])
          node = node.parent

  result.toTheTop()

proc part1(filename: string, maxSize: int64 = 100000): int64 =

  proc recurseMe(node: PathEntry): int64 =
    if node.size < maxSize:
      result += node.size
    for val in node.kids.values:
      result += recurseMe(val)

  result = recurseMe(parse(filename))

proc part2(filename: string, maxSpace: int64 = 70000000,
    requiredSpace: int64 = 30000000): int64 =

  proc recurseMe(node: PathEntry, wanted, bestSoFar: int64): int64 =
    result = bestSoFar
    if node.size > wanted and node.size < bestSoFar:
      result = node.size
    for val in node.kids.values:
      result = recurseMe(val, wanted, result)

  var workingDir = parse(filename)
  result = recurseMe(workingDir, requiredSpace - (maxSpace - workingDir.size), int64.high)

when isMainModule:
  doAssert part1("../data/day07_example.txt") == 95437
  echo part1("../data/day07_input.txt")

  doAssert part2("../data/day07_example.txt") == 24933642
  echo part2("../data/day07_input.txt")
