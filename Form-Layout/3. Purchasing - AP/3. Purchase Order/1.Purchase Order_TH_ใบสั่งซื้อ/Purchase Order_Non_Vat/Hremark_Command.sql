-- ============================================================
-- Report: Purchase Order_Non_Vat.rpt
Path:   Purchase Order_Non_Vat.rpt
Extracted: 2026-07-28 00:21:43
-- Source: Subreport [Hremark]
-- Table:  Command
-- ============================================================

SELECT [LineText]
FROM POR10
WHERE [DocEntry] = {?DocKey@}
  AND [AftLineNum] = -1
ORDER BY [LineSeq] ASC

