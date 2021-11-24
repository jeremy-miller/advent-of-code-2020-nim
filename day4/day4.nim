import strutils
import std/strformat
import std/strscans

let data = readFile("day4/data").splitLines()

const
  requiredFields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]       # cid is optional
  requiredFieldsCount = len(requiredFields)
var
  validPassports = 0
  passportFieldCount = requiredFieldsCount
for line in data:
  if len(line) > 0:
    let keyVals = line.split(" ")
    for keyVal in keyVals:
      let field = keyVal.split(":")
      let fieldName = field[0]
      if fieldName in requiredFields:
        passportFieldCount -= 1
  else: # empty line signifying end of previous  passport
    if passportFieldCount == 0:
      validPassports += 1
    passportFieldCount = requiredFieldsCount # reset for next passport

echo fmt"Part 1: {validPassports}"

const eyeColor = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

func validField(field: seq[string]): bool =
  let
    fieldName = field[0]
    fieldValue = field[1]
  if fieldName in requiredFields:
    case fieldName
    of "byr":
      try:
        let byr = parseInt(fieldValue)
        return byr >= 1920 and byr <= 2002
      except ValueError:
        return false
    of "iyr":
      try:
        let iyr = parseInt(fieldValue)
        return iyr >= 2010 and iyr <= 2020
      except ValueError:
        return false
    of "eyr":
      try:
        let eyr = parseInt(fieldValue)
        return eyr >= 2020 and eyr <= 2030
      except ValueError:
        return false
    of "hgt":
      try:
        let
          value = fieldValue[0 ..< ^2].parseInt
          unit = fieldValue[^2 .. ^1]
        if unit == "cm":
          return value >= 150 and value <= 193
        elif unit == "in":
          return value >= 59 and value <= 76
        else:
          return false
      except ValueError:
        return false
    of "hcl":
      var hcl: int
      return len(fieldValue) == 7 and scanf(fieldValue, "$h", hcl)
    of "ecl":
      return fieldValue in eyeColor
    of "pid":
      try:
        discard parseInt(fieldValue) # just making sure it's a valid number
        return len(fieldValue) == 9
      except ValueError:
        return false
  else:
    return false

validPassports = 0
passportFieldCount = requiredFieldsCount
for line in data:
  if len(line) > 0:
    let keyVals = line.split(" ")
    for keyVal in keyVals:
      let field = keyVal.split(":")
      let fieldName = field[0]
      if fieldName in requiredFields and validField(field):
        passportFieldCount -= 1
  else: # empty line signifying end of previous  passport
    if passportFieldCount == 0:
      validPassports += 1
    passportFieldCount = requiredFieldsCount # reset for next passport

echo fmt"Part 2: {validPassports}"
