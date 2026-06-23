-- ============================================================
-- Report: 1.Outgoing Payments_ใบจ่ายชำระ.rpt
Path:   1.Outgoing Payments_ใบจ่ายชำระ.rpt
Extracted: 2026-06-24 00:44:14
-- Source: Subreport [Bank]
-- Table:  Command
-- ============================================================

select T1.DueDate ,T1.CheckNum ,T1.BankCode ,T1.Branch 
,T1.AcctNum ,T1.[CheckSum] ,T1.[DocNum]
from vpm1 T1
--Where convert(nvarchar,T1.[DocNum]) = '{?Docnum}'

