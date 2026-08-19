-- ============================================================
-- Report: 1.Goods Reciept PO_TH_ใบรับสินค้า_(Batch_Serial).rpt
Path:   1.Goods Reciept PO_TH_ใบรับสินค้า_(Batch_Serial).rpt
Extracted: 2026-07-28 00:22:58
-- Source: Subreport [Remark]
-- Table:  Command
-- ============================================================

SELECT
    TOP 1 PDN10.LineText
FROM PDN1
INNER JOIN PDN10 ON PDN1.[DocEntry] = PDN10.[DocEntry] AND PDN10.AftLineNum = {?lineNum@}
WHERE PDN1.[DocEntry] = {?DocKey@}
