import std/sequtils

# https://adventofcode.com/2022/day/8

proc part1(filename: string): int =
  var heights: seq[seq[char]]
  for l in filename.lines:
    heights.add toSeq(l)

  result = (heights.len * 2) + ((heights[0].len - 2) * 2)

  for y in 1 .. heights.high - 1:
    for x in 1 .. heights[y].high - 1:
      if max(heights[y].toOpenArray(0, x - 1)) < heights[y][x] or
         max(heights[y].toOpenArray(x + 1, heights[y].high)) < heights[y][x]:
        inc result
      else:
        var highest = '\0'
        for yy in 0 .. y - 1:
          highest = max(heights[yy][x], highest)
        if heights[y][x] > highest:
          inc result
        else:
          var highest = '\0'
          for yy in y + 1 .. heights.high:
            highest = max(heights[yy][x], highest)
          if heights[y][x] > highest:
            inc result

proc part2(filename: string): int =
  var heights: seq[seq[char]]
  for l in filename.lines:
    heights.add toSeq(l)

  proc visible(startX, startY, deltaX, deltaY: int): int =
    var
      newX = startX
      newY = startY
      height = heights[startY][startX]
    while true:
      inc newX, deltaX
      inc newY, deltaY
      if newX notin 0 .. heights[0].high or newY notin 0 .. heights.high: break
      inc result
      if heights[newY][newX] >= height: break

  for y in 1 .. heights.high - 1:
    for x in 1 .. heights[y].high - 1:
      let scenicHeight = visible(x, y, -1, 0) * visible(x, y, 1, 0) * visible(x,
          y, 0, -1) * visible(x, y, 0, 1)
      result = max(result, scenicHeight)

when isMainModule:
  doAssert part1("../data/day08_example.txt") == 21
  echo part1("../data/day08_input.txt")

  doAssert part2("../data/day08_example.txt") == 8
  echo part2("../data/day08_input.txt")
