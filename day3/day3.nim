import sequtils
import strutils
import std/strformat

let
    data = readFile("day3/data")
    grid = data.splitLines.filterIt(it.len > 0)
    rows = len(grid)
    cols = len(grid[0])

proc countTrees(dx, dy: int): int =
    var
        count = 0
        x = 0
        y = 0
    while y < rows:
        let row = grid[y]
        if row[x] == '#':
            count += 1
        x = (x + dx) mod cols
        y += dy
    return count

let treeCount = countTrees(3, 1)

echo fmt"Part 1: {treeCount}"

const slopes = [
    (dx: 1, dy: 1),
    (dx: 3, dy: 1),
    (dx: 5, dy: 1),
    (dx: 7, dy: 1),
    (dx: 1, dy: 2)
]

var allTreeCount = 1

for slope in slopes:
    allTreeCount *= countTrees(slope.dx, slope.dy)

echo fmt"Part 2: {allTreeCount}"
