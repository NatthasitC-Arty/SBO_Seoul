-- ============================================================
-- Report: Purchase Order_Vat_Show.rpt
Path:   Purchase Order_Vat_Show.rpt
Extracted: 2026-07-28 00:21:44
-- Source: Subreport [Hremark]
-- Table:  Command
-- ============================================================

SELECT [LineText]
FROM POR10
WHERE [DocEntry] = {?DocKey@}
  AND [AftLineNum] = -1
ORDER BY [LineSeq] ASC

