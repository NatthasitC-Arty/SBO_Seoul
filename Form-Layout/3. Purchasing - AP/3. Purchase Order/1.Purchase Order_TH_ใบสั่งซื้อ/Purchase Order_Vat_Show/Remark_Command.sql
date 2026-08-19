-- ============================================================
-- Report: Purchase Order_Vat_Show.rpt
Path:   Purchase Order_Vat_Show.rpt
Extracted: 2026-07-28 00:21:44
-- Source: Subreport [Remark]
-- Table:  Command
-- ============================================================

SELECT 
    TOP (ISNULL((SELECT MAX(OrderNum) FROM POR10 WHERE [DocEntry] = {?DocKey@} AND AftLineNum = {?lineNum@}), 0)) POR10.LineText
FROM POR1
INNER JOIN POR10 ON POR1.[DocEntry] = POR10.[DocEntry] AND POR10.AftLineNum = {?lineNum@}
WHERE POR1.[DocEntry] = {?DocKey@}


