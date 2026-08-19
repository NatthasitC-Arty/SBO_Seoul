-- ============================================================
-- Report: Purchase Order_Vat_Show.rpt
Path:   Purchase Order_Vat_Show.rpt
Extracted: 2026-07-28 00:21:44
-- Source: Main Report
-- Table:  Create
-- ============================================================

SELECT CONCAT(lastName,'  ',firstName) AS 'Name Create'
,OPOR.DocDate
FROM OPOR 
LEFT JOIN OHEM ON OPOR.UserSign = OHEM.userId
WHERE OPOR.DocEntry  = {?DocKey@}
