import std/[sequtils, sets]

# https://adventofcode.com/2022/day/6

proc firstUnique(input: string, bufferLength: int): int =
  var buffer = newSeqWith(bufferLength, ' ')
  var ringBufferIdx = 0
  for idx, ch in input:
    buffer[ringBufferIdx] = ch
    if idx > buffer.high and buffer.toHashSet.card == buffer.len:
      return idx + 1
    ringBufferIdx = (ringBufferIdx + 1) mod buffer.len

proc part1(input: string): int = firstUnique(input, 4)
proc part2(input: string): int = firstUnique(input, 14)

when isMainModule:
  doAssert part1("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 7
  doAssert part1("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
  doAssert part1("nppdvjthqldpwncqszvftbrmjlhg") == 6
  doAssert part1("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
  doAssert part1("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
  echo part1(readFile "../data/day06_input.txt")

  doAssert part2("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 19
  doAssert part2("bvwbjplbgvbhsrlpgdmjqwftvncz") == 23
  doAssert part2("nppdvjthqldpwncqszvftbrmjlhg") == 23
  doAssert part2("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 29
  doAssert part2("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 26
  echo part2(readFile "../data/day06_input.txt")
