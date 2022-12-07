import std/[strutils, tables]

# https://adventofcode.com/2022/day/7

proc part1(filename: string, maxSize: int64 = 100000): int64 =
  type
    PathEntry = ref object
      parent: PathEntry
      kids: Table[string, PathEntry]
      name: string
      size: int64

  var workingDir = PathEntry(parent: nil, name: "/")

  proc toTheTop() =
    while workingDir.parent != nil: workingDir = workingDir.parent

  for l in filename.lines:
    if l == "$ cd ..":
      workingDir = workingDir.parent
    elif l == "$ cd /":
      toTheTop()
    elif l.startsWith "$ cd":
      let folder = l.split("$ cd ")[1]
      discard workingDir.kids.mgetOrPut(folder, PathEntry(parent: workingDir, name: folder))
      workingDir = workingDir.kids[folder]
    elif not l.startsWith("$ ls") and not l.startsWith("dir"):
      let file = l.split(" ") # size, name
      if not workingDir.kids.hasKey(file[1]):
        workingDir.kids[file[1]] = PathEntry(parent: workingDir, name: file[1],
            size: maxSize + 1) # so they avoid getting caught in the size calculations later
        var node = workingDir
        while node != nil:
          node.size += parseInt(file[0])
          node = node.parent

  proc printMe(node: PathEntry, levels: int = 0) =
    echo repeat(' ', levels * 2) & node.name & " (" & $node.size & ")"
    for val in node.kids.values:
      printMe(val, levels + 1)

  proc recurseMe(node: PathEntry): int64 =
    if node.size < maxSize:
      result += node.size
    for val in node.kids.values:
      result += recurseMe(val)

  toTheTop()
  printMe(workingDir)
  result = recurseMe(workingDir)

#proc part2(filename: string): int =
#  0

when isMainModule:
  doAssert part1("../data/day07_example.txt") == 95437
  echo part1("../data/day07_input.txt")

  #doAssert part2("../data/day07_example.txt") == 24933642
  #echo part2("../data/day07_input.txt")
