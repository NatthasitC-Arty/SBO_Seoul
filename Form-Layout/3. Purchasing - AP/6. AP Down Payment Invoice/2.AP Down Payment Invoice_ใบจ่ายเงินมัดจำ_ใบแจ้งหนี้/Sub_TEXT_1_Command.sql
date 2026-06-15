SELECT [LineText]
FROM DPO10
WHERE [DocEntry] = {?DocKey@}
  AND [AftLineNum] = {?lineNum@}
ORDER BY [LineSeq] ASC
