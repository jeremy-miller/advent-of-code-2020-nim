import sequtils
import strutils
import std/strformat
import std/strscans


type Password = tuple[a, b: int, chr: char, password: string]

func parseInput(input: string): Password =
    const pattern = "$i-$i$s$c:$s$w"
    var
        a, b: int
        chr: char
        password: string
    if scanf(input, pattern, a, b, chr, password):
        return (a: a, b: b, chr: chr, password: password)

let data = readFile("day2/data")
let passwords = data.splitLines.filterIt(it.len > 0).map(parseInput)

var count = 0
for p in passwords:
    if count(p.password, p.chr) >= p.a and count(p.password, p.chr) <= p.b:
        count += 1

echo fmt"Part 1: {count}"

count = 0
for p in passwords:
    if (p.password[p.a-1] == p.chr and p.password[p.b-1] != p.chr) or
       (p.password[p.a-1] != p.chr and p.password[p.b-1] == p.chr):
        count += 1

echo fmt"Part 2: {count}"
