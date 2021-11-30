import sequtils
import strutils
import std/math

const
  rowChars = ['F', 'B']
  seatChars = ['L', 'R']

let boardingPasses = readFile("day5/data").splitLines.filterIt(it.len > 0)

func binarySpacePartition(min, max: int, chr: char, chars: array[2, char]): tuple[newMin, newMax: int] {.raises: [].} =
  let mid = ceilDiv((max - min), 2)
  if chr == chars[0]:
    return (min, max - mid)
  else:
    return (min + mid, max)

var largestSeatID = 0
for boardingPass in boardingPasses:
  var
    rowMin = 0
    rowMax = 127
    seatMin = 0
    seatMax = 7
  for chr in boardingPass[0 ..< ^3]:
    (rowMin, rowMax) = binarySpacePartition(rowMin, rowMax, chr, rowChars)
  let row = rowMin
  for chr in boardingPass[^3 .. ^1]:
    (seatMin, seatMax) = binarySpacePartition(seatMin, seatMax, chr, seatChars)
  let
    seat = seatMin
    seatID = row * 8 + seat
  if seatID > largestSeatID:
    largestSeatID = seatID

echo "Part 1: ", largestSeatID

var seats = newSeq[bool](largestSeatID + 1)
for boardingPass in boardingPasses:
  var
    rowMin = 0
    rowMax = 127
    seatMin = 0
    seatMax = 7
  for chr in boardingPass[0 ..< ^3]:
    (rowMin, rowMax) = binarySpacePartition(rowMin, rowMax, chr, rowChars)
  let row = rowMin
  for chr in boardingPass[^3 .. ^1]:
    (seatMin, seatMax) = binarySpacePartition(seatMin, seatMax, chr, seatChars)
  let
    seat = seatMin
    seatID = row * 8 + seat
  seats[seatID] = true

for idx, value in seats:
  if not value and idx > 0 and idx < len(seats) and seats[idx-1] and seats[idx+1]:
    echo "Part 2: ", idx
    break
