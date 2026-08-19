-- ============================================================
-- Report: Purchase Order_Vat_Show.rpt
Path:   Purchase Order_Vat_Show.rpt
Extracted: 2026-07-28 00:21:44
-- Source: Main Report
-- Table:  Address
-- ============================================================

SELECT DISTINCT
    CAST(CompnyName AS NVARCHAR(MAX)) AS CompnyName,
    CAST(adm1.Street AS NVARCHAR(MAX)) AS 'adm1_Street',
    CAST(adm1.Block AS NVARCHAR(MAX)) AS 'adm1_Block',
    CAST(adm1.City AS NVARCHAR(MAX)) AS 'adm1_City',
    CAST(adm1.County AS NVARCHAR(MAX)) AS 'adm1_County',
    CAST(adm1.ZipCode AS NVARCHAR(MAX)) AS 'adm1_ZipCode',
    CAST(AliasName AS NVARCHAR(MAX)) AS AliasName,
    CAST(Phone1 AS NVARCHAR(MAX)) AS Phone1,
    CAST(IntrntAdrs AS NVARCHAR(MAX)) AS IntrntAdrs, 
    CAST(RevOffice AS NVARCHAR(MAX)) AS RevOffice,
    CASE 
        WHEN CAST(adm1.GlblLocNum AS NVARCHAR(MAX)) = '00000' THEN N'สำนักงานใหญ่'
        WHEN CAST(adm1.GlblLocNum AS NVARCHAR(MAX)) <> '00000' THEN N'สาขาที่ ' + CAST(adm1.GlblLocNum AS NVARCHAR(MAX))
    END AS 'GLN_H'

FROM oadm, adm1, ADM2

