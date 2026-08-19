-- ============================================================
-- Report: 1.Goods Reciept PO_TH_ใบรับสินค้า_(Batch_Serial).rpt
Path:   1.Goods Reciept PO_TH_ใบรับสินค้า_(Batch_Serial).rpt
Extracted: 2026-07-28 00:22:58
-- Source: Main Report
-- Table:  Create
-- ============================================================

SELECT firstName , lastName  
FROM OHEM   
LEFT JOIN OPDN ON OHEM.Code = OPDN.U_SLD_Empname
WHERE OPDN.DocEntry  = {?Dockey@}
