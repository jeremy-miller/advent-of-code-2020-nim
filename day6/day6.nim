import std/tables
import strutils

let customsForms = readFile("day6/data").splitLines()

var
  yesQuestionsAny: set[char] = {}
  yesCountAny = 0
for customsForm in customsForms:
  if len(customsForm) == 0: # new family
    yesCountAny += len(yesQuestionsAny)
    yesQuestionsAny = {}
  else:
    for question in customsForm:
      yesQuestionsAny = yesQuestionsAny + {question}

echo "Part 1: ", yesCountAny

var
  yesQuestionsAll = initCountTable[char]()
  yesCountAll = 0
  familyMemberCount = 0
for customsForm in customsForms:
  if len(customsForm) == 0: # new family
    for familyYesCount in values(yesQuestionsAll):
      if familyYesCount == familyMemberCount:
        yesCountAll += 1
    yesQuestionsAll = initCountTable[char]()
    familyMemberCount = 0
  else:
    familyMemberCount += 1
    for question in customsForm:
      yesQuestionsAll.inc(question)

echo "Part 2: ", yesCountAll
