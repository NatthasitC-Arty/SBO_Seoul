-- ============================================================
-- Report: Purchase Order_Non_Vat.rpt
Path:   Purchase Order_Non_Vat.rpt
Extracted: 2026-07-28 00:21:43
-- Source: Main Report
-- Table:  Command
-- ============================================================

SELECT CONCAT(lastName,'  ',firstName) AS 'Name Create'
,OPOR.DocDate
FROM OPOR 
LEFT JOIN OHEM ON OPOR.UserSign = OHEM.userId
WHERE OPOR.DocEntry  = {?DocKey@}
