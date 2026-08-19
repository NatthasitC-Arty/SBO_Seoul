-- ============================================================
-- Report: 1.Goods Reciept PO_TH_ใบรับสินค้า_(Batch_Serial).rpt
Path:   1.Goods Reciept PO_TH_ใบรับสินค้า_(Batch_Serial).rpt
Extracted: 2026-07-28 00:22:58
-- Source: Subreport [Hremark]
-- Table:  Command
-- ============================================================

SELECT [LineText]
FROM PDN10
WHERE [DocEntry] = {?DocKey@}
  AND [AftLineNum] = -1
ORDER BY [LineSeq] ASC
