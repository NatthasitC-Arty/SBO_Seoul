SELECT [LineText]
FROM QUT10
WHERE [DocEntry] = {?DocKey@}
  AND [AftLineNum] = {?lineNum@}
ORDER BY [LineSeq] ASC
