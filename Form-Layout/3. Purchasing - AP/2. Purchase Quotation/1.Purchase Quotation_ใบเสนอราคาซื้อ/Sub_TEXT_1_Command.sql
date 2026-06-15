SELECT [LineText]
FROM PQT10
WHERE [DocEntry] = {?DocKey@}
  AND [AftLineNum] = {?lineNum@}
ORDER BY [LineSeq] ASC
