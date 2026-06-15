SELECT [LineText]
FROM POR10
WHERE [DocEntry] = {?DocKey@}
  AND [AftLineNum] = {?lineNum@}
ORDER BY [LineSeq] ASC
