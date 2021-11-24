import sequtils
import strutils
import std/strformat

let data = readFile("day1/data")
let ns = data.splitLines.filterIt(it.len > 0).map(parseInt)

block part1:
  for x in ns:
    for y in ns:
      if x + y == 2020:
        echo fmt"Part 1: {x} * {y} = {x * y}"
        break part1

block part2:
  for x in ns:
    for y in ns:
      for z in ns:
        if x + y + z == 2020:
          echo fmt"Part 2: {x} * {y} * {z} = {x * y * z}"
          break part2
