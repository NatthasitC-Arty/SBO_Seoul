-- ============================================================
-- Report: 1.Purchase Order_TH_ใบสั่งซื้อ.rpt
Path:   1.Purchase Order_TH_ใบสั่งซื้อ.rpt
Extracted: 2026-06-16 17:07:12
-- Source: Main Report
-- Table:  Create
-- ============================================================

SELECT CONCAT(firstName,'  ',lastName) AS 'Name Create'
FROM OPOR 
LEFT JOIN OHEM ON OPOR.UserSign = OHEM.userId
WHERE OPOR.DocEntry  = {?DocKey@}
