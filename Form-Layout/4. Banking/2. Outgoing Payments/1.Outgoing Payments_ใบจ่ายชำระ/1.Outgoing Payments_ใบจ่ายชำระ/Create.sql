-- ============================================================
-- Report: 1.Outgoing Payments_ใบจ่ายชำระ.rpt
Path:   1.Outgoing Payments_ใบจ่ายชำระ.rpt
Extracted: 2026-06-24 00:44:14
-- Source: Main Report
-- Table:  Create
-- ============================================================

SELECT CONCAT(OHEM.lastname , ' ' , OHEM.firstname) AS 'Name'
FROM OVPM  
LEFT JOIN OHEM ON OVPM.UserSign = OHEM.userId
WHERE OVPM.DocEntry  = {?DocKey@}
