-- ============================================================
-- Report: 1.Goods Reciept PO_TH_ใบรับสินค้า_(Batch_Serial).rpt
Path:   1.Goods Reciept PO_TH_ใบรับสินค้า_(Batch_Serial).rpt
Extracted: 2026-07-28 00:22:58
-- Source: Main Report
-- Table:  Command
-- ============================================================

SELECT OcrName
FROM OOCR 
INNER JOIN PDN1 
ON OOCR.OcrCode = PDN1.OcrCode2
WHERE PDN1.DocEntry  = {?Dockey@}
