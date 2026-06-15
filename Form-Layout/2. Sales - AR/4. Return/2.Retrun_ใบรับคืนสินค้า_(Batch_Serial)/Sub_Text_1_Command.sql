SELECT [LineText]
FROM RDN10
WHERE [DocEntry] = {?DocKey@}
  AND [AftLineNum] = {?lineNum@}
ORDER BY [LineSeq] ASC
